;;;; Regenerate the Autolith docs pages under autolith/docs/.
;;;
;;; The manual is a serial document: every page carries a contents window
;;; beside its content with the current entry fully inverted, and previous
;;; and next remain actions at the end. The generator reads the body,
;;; location breadcrumb, and adjacent-pages pager of each published page
;;; and rewrites the chrome around them, so regeneration never touches the
;;; checked prose itself.
;;;
;;; Load this file from the repository checkout and call MAKE-DOCS:
;;;
;;;   sbcl --non-interactive \
;;;     --eval "(load \"tools/make-docs.lisp\")" --eval "(make-docs)"

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :asdf))

(defparameter *docs-dir*
  (let* ((self (truename (or *load-pathname* *compile-file-pathname*)))
         ;; The tool lives in tools/, so its parent directory is the
         ;; repository root.
         (root (uiop:pathname-parent-directory-pathname self)))
    (merge-pathnames "autolith/docs/" root))
  "Directory the rendered docs pages are written to.")

(defparameter *docs-favicon*
  "/logo/ls-favicon.svg"
  "The house logotype, shared by every docs page.")

(defparameter *docs-toc*
  '(("Start"
     ("install" "Install")
     ("first-session" "Your first session")
     ("workspace" "The workspace"))
    ("Concepts"
     ("tools" "Tools and permissions")
     ("lisp-workers" "Lisp workers")
     ("live-image" "The live image")
     ("commits-and-recovery" "Commit and recover")
     ("state" "State")
     ("recursive-inference" "Recursive inference")
     ("agents-and-jobs" "Agents and jobs")
     ("providers" "Providers")
     ("mcp" "MCP")
     ("skills" "Skills"))
    ("Reference"
     ("commands" "Slash commands"))
    ("Cookbook"
     ("cookbook/resume-and-replay" "Find and resume past work")
     ("cookbook/persist-a-function" "Keep a helper across restarts")
     ("cookbook/search-big-corpus" "Search a corpus larger than the window")
     ("cookbook/run-from-ci" "Run Autolith from CI")
     ("cookbook/add-mcp-server" "Add an MCP server")
     ("cookbook/project-setup" "Set up a project for Autolith"))
    ("Advanced"
     ("advanced/management-endpoint" "The management endpoint")
     ("advanced/context-tuning" "Context tuning")))
  "The manual order: each part names its pages as slug and title.")

(defparameter *docs-revised* "7 September 2026"
  "Revision stamp shown in the docs colophon.")

(defun docs-read (path)
  "Return the whole file at PATH as one string."
  (with-open-file (in path :external-format :utf-8)
    (with-output-to-string (buffer)
      (loop for char = (read-char in nil nil)
            while char
              do (write-char char buffer)))))

(defun docs-write (path text)
  "Write TEXT to PATH, creating its directory when needed."
  (ensure-directories-exist path)
  (with-open-file (out path :direction :output :if-exists :supersede
                       :external-format :utf-8)
    (write-string text out)))

(defun docs-count-all (text needle)
  "Count every occurrence of NEEDLE in TEXT, including overlaps."
  (loop with start = 0 and total = 0
        for found = (search needle text :start2 start)
        while found
          do (incf total)
             (setf start (1+ found))
        finally (return total)))

(defun docs-tag-open (text tag)
  "Count opening TAG tags in TEXT."
  (+ (docs-count-all text (concatenate 'string "<" tag ">"))
     (docs-count-all text (concatenate 'string "<" tag " "))))

(defun docs-tag-close (text tag)
  "Count closing TAG tags in TEXT."
  (+ (docs-count-all text (concatenate 'string "</" tag ">"))
     (docs-count-all text (concatenate 'string "</" tag " "))))

(defun docs-check-balance (text)
  "Signal when any structural tag is unbalanced in TEXT."
  (dolist (tag '("div" "nav" "section" "ul" "ol" "dl" "table" "pre" "p" "h1" "h2" "h3"))
    (let ((open-count (docs-tag-open text tag))
          (close-count (docs-tag-close text tag)))
      (unless (= open-count close-count)
        (error "unbalanced <~A>: ~D open, ~D close" tag open-count close-count)))))

(defun docs-expect (text start needle)
  "Return the index of NEEDLE in TEXT at or after START, or signal."
  (or (search needle text :start2 start)
      (error "a docs page is missing ~S" needle)))

(defun docs-between (text open close)
  "Return the text in TEXT between the first OPEN and the following CLOSE."
  (let* ((a (docs-expect text 0 open))
         (b (docs-expect text (+ a (length open)) close)))
    (subseq text (+ a (length open)) b)))

(defun docs-url (slug)
  "Canonical URL of the page identified by SLUG."
  (if (or (null slug) (string= slug ""))
      "https://lambda-symbolics.com/autolith/docs"
      (format nil "https://lambda-symbolics.com/autolith/docs/~A" slug)))

(defun docs-href (slug)
  "Site-local href of the page identified by SLUG."
  (if (or (null slug) (string= slug ""))
      "/autolith/docs"
      (format nil "/autolith/docs/~A" slug)))

(defun docs-file (slug)
  "Output path of the page identified by SLUG."
  (merge-pathnames
   (if (or (null slug) (string= slug ""))
       "index.html"
       (concatenate 'string slug ".html"))
   *docs-dir*))

(defun docs-strip-breadcrumb (chunk)
  "Split a leading location breadcrumb off CHUNK."
  (let ((lead (search "      <nav class=\"docs-path\"" chunk)))
    (if (eql lead 0)
        (let* ((close (docs-expect chunk 0 "</nav>"))
               (after (+ close (length "</nav>"))))
          (values (subseq chunk 0 after)
                  (string-left-trim '(#\Newline) (subseq chunk after))))
        (values nil chunk))))

(defun docs-strip-wrapper (chunk)
  "Remove a previous render's contents layout, leaving body and pager."
  (if (eql (search "      <div class=\"doc-body\">" chunk) 0)
      (let* ((open "      <div class=\"doc-body\">
        <div class=\"doc-content\">
")
             (start (docs-expect chunk 0 open))
             (start (+ start (length open)))
             (aside (docs-expect chunk start "
        <aside class=\"doc-contents\">"))
             (end (- aside (length "
        </div>"))))
        (subseq chunk start end))
      chunk))

(defun docs-split-pager (chunk)
  "Split CHUNK into the body and the adjacent-pages nav."
  (let ((pos (search "
      <nav class=\"docs-pager\"" chunk)))
    (if pos
        (values (subseq chunk 0 pos)
                (string-right-trim '(#\Newline) (subseq chunk (1+ pos))))
        (values chunk nil))))

(defun docs-parse-page (slug)
  "Read the published page SLUG and return its chrome pieces."
  (let* ((text (docs-read (docs-file slug)))
         (title (docs-between text "<title>" "</title>"))
         (description
          (docs-between text "<meta name=\"description\" content=\"" "\">"))
         (open "<main id=\"main-content\" class=\"shell doc-page\">
")
         (body-start (docs-expect text 0 open))
         (body-start (+ body-start (length open)))
         (main-close (docs-expect text body-start "    </main>"))
         (chunk (string-left-trim '(#\Newline)
                                  (subseq text body-start main-close))))
    (multiple-value-bind (breadcrumb rest) (docs-strip-breadcrumb chunk)
      (multiple-value-bind (body pager) (docs-split-pager (docs-strip-wrapper rest))
        (list :slug slug
              :title title
              :description description
              :breadcrumb breadcrumb
              :body body
              :pager pager)))))

(defun docs-toc-items (current-slug)
  "Render the contents list for a manual page, inverting the current entry."
  (with-output-to-string (out)
    (let ((number 0))
      (dolist (part *docs-toc*)
        (format out "                <li class=\"toc-part\">~A</li>~%" (first part))
        (dolist (entry (rest part))
          (incf number)
          (destructuring-bind (slug title) entry
            (if (string= slug current-slug)
                (format out "                <li><span class=\"toc-current\"><span class=\"toc-number\">~D</span>~A</span></li>~%"
                        number title)
                (format out "                <li><a href=\"~A\"><span class=\"toc-number\">~D</span>~A</a></li>~%"
                        (docs-href slug) number title))))))))

(defun docs-contents-aside (current-slug)
  "Render the contents window shown beside a manual page."
  (format nil "        <aside class=\"doc-contents\">
          <div class=\"window\">
            <div class=\"window-titlebar\">Contents</div>
            <div class=\"window-body\">
              <ul class=\"toc-list\">
~A              </ul>
            </div>
          </div>
        </aside>"
          (docs-toc-items current-slug)))

(defun docs-render (page)
  "Render one parsed page with the current docs chrome."
  (let* ((slug (getf page :slug))
         (head-title (getf page :title))
         (description (getf page :description))
         (pager (or (getf page :pager) ""))
         (index (or (null slug) (string= slug ""))))
    (concatenate 'string
"<!DOCTYPE html>
<html lang=\"en\">
  <head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>" head-title "</title>
    <meta name=\"description\" content=\"" description "\">
    <link rel=\"canonical\" href=\"" (docs-url slug) "\">

    <meta property=\"og:title\" content=\"" head-title "\">
    <meta property=\"og:description\" content=\"" description "\">
    <meta property=\"og:type\" content=\"website\">
    <meta property=\"og:url\" content=\"" (docs-url slug) "\">
    <meta property=\"og:site_name\" content=\"Lambda Symbolics OÜ\">

    <link rel=\"icon\" href=\"" *docs-favicon* "\" type=\"image/svg+xml\">
    <link rel=\"stylesheet\" href=\"/paper.css\">
  </head>
  <body>
    <a class=\"skip-link\" href=\"#main-content\">Skip to content</a>

    <header class=\"shell\">
      <div class=\"letterhead\">
        <a class=\"wordmark\" href=\"/\"><img src=\"/logo/ls-wordmark.svg\" alt=\"Lambda Symbolics\" width=\"110\" height=\"31\"></a>
        <nav class=\"site-nav\" aria-label=\"Primary\">
          <ul class=\"site-nav-list\">
            <li><a href=\"/autolith\">Autolith</a></li>
            <li><a href=\"/autolith/docs\">Docs</a></li>
            <li><a href=\"https://github.com/lambda-symbolics/autolith\">GitHub</a></li>
          </ul>
        </nav>
      </div>
    </header>

    <main id=\"main-content\" class=\"shell doc-page\">
"
(when (getf page :breadcrumb)
  (concatenate 'string (getf page :breadcrumb) "

"))
(if index
    (concatenate 'string
                 (getf page :body)
                 "
"
                 pager
                 "
    </main>")
    (concatenate 'string
                 "      <div class=\"doc-body\">
        <div class=\"doc-content\">
"
                 (getf page :body)
                 "
"
                 pager
                 "
        </div>

"
                 (docs-contents-aside slug)
                 "
      </div>
    </main>"))
"
    <footer class=\"shell\">
      <div class=\"colophon\">
        <p>© 2026 Lambda Symbolics OÜ · <a href=\"/lukas\">me</a></p>
        <p>Autolith docs · Revised " *docs-revised* "</p>
      </div>
    </footer>
  </body>
</html>
")))

(defun docs-slugs ()
  "Every manual slug in reading order."
  (loop for part in *docs-toc*
        append (mapcar #'first (rest part))))

(defun make-docs ()
  "Regenerate every Autolith docs page from its published body."
  (dolist (slug (cons "" (docs-slugs)))
    (let* ((page (docs-parse-page slug))
           (text (docs-render page)))
      (docs-check-balance text)
      (docs-write (docs-file slug) text)
      (format t "wrote ~A (~D bytes)~%" (docs-file slug) (length text)))))
