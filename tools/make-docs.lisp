;;;; Generate the public Autolith manual from docs/guide.org.
;;;
;;; Usage:
;;;   AUTOLITH_GUIDE=/path/to/autolith/docs/guide.org \
;;;     sbcl --non-interactive --load tools/make-docs.lisp \
;;;     --eval '(make-docs)'

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :asdf))

(defparameter *site-root*
  (uiop:pathname-parent-directory-pathname
   (truename (or *load-pathname* *compile-file-pathname*))))
(defparameter *docs-dir* (merge-pathnames "autolith/docs/" *site-root*))
(defparameter *guide-path*
  (pathname (or (uiop:getenv "AUTOLITH_GUIDE")
                "~/common-lisp/frob/docs/guide.org")))
(defparameter *pandoc-filter*
  (merge-pathnames "tools/pandoc-autolith.lua" *site-root*))
(defparameter *docs-revised* "11 October 2026")
(defparameter *paper-css-url*
  (format nil "/paper.css?v=~A"
          (subseq (uiop:run-program
                   (list "sha256sum"
                         (namestring (merge-pathnames "paper.css" *site-root*)))
                   :output :string)
                  0 64)))

(defparameter *docs-favicon* "/logo/ls-favicon.svg")
(defparameter *legacy-redirects*
  '( ("install" . "install-update-and-uninstall")
     ("first-session" . "talk-to-autolith")
     ("workspace" . "talk-to-autolith#managed-resources")
     ("tools" . "configure-autolith#worker-tool-calls")
     ("lisp-workers" . "configure-autolith#worker-tool-calls")
     ("live-image" . "generations-and-recovery")
     ("commits-and-recovery" . "generations-and-recovery")
     ("state" . "generations-and-recovery")
     ("recursive-inference" . "configure-autolith#context")
     ("agents-and-jobs" . "configure-autolith#child-roles")
     ("providers" . "configure-autolith#providers")
     ("mcp" . "configure-autolith#settings")
     ("skills" . "configure-autolith#executable-skills")
     ("commands" . "configure-autolith#commands")
     ("cookbook/resume-and-replay" . "generations-and-recovery")
     ("cookbook/persist-a-function" . "configure-autolith#live-definitions")
     ("cookbook/search-big-corpus" . "configure-autolith#context")
     ("cookbook/run-from-ci" . "non-interactive-jobs")
     ("cookbook/add-mcp-server" . "configure-autolith#settings")
     ("cookbook/project-setup" . "configure-autolith#settings")
     ("advanced/management-endpoint" . "configure-autolith#active-image-management-endpoint")
     ("advanced/context-tuning" . "configure-autolith#context")))

(defun docs-read (path)
  (uiop:read-file-string path :external-format :utf-8))

(defun docs-write (path text)
  (ensure-directories-exist path)
  (with-open-file (out path :direction :output :if-exists :supersede
                       :external-format :utf-8)
    (write-string text out)))

(defun docs-file (slug)
  (merge-pathnames (if (string= slug "") "index.html"
                       (format nil "~A.html" slug))
                   *docs-dir*))

(defun docs-url (slug)
  (if (string= slug "")
      "https://lambda-symbolics.com/autolith/docs"
      (format nil "https://lambda-symbolics.com/autolith/docs/~A" slug)))

(defun docs-href (slug)
  (if (string= slug "") "/autolith/docs"
      (format nil "/autolith/docs/~A" slug)))

(defun docs-guide-html ()
  (unless (probe-file *guide-path*)
    (error "Autolith guide not found: ~A" *guide-path*))
  (uiop:run-program
   (list "pandoc" "--from=org" "--to=html5" "--wrap=none"
         "--highlight-style=pygments"
         (format nil "--lua-filter=~A" (namestring *pandoc-filter*))
         (namestring (truename *guide-path*)))
   :output :string :error-output :string))

(defun docs-h1-positions (html)
  (loop with positions = nil and start = 0
        for found = (search "<h1 id=\"" html :start2 start)
        while found do (push found positions) (setf start (1+ found))
        finally (return (nreverse positions))))

(defun docs-attribute (tag name)
  (let* ((prefix (format nil "~A=\"" name))
         (start (search prefix tag)))
    (unless start (error "Missing ~A in ~A" name tag))
    (let ((value-start (+ start (length prefix))))
      (subseq tag value-start (position #\" tag :start value-start)))))

(defun docs-strip-tags (text)
  (with-output-to-string (out)
    (loop with inside = nil for char across text
          do (cond ((char= char #\<) (setf inside t))
                   ((char= char #\>) (setf inside nil))
                   ((not inside) (write-char char out))))))

(defun docs-chapters (html)
  (let ((positions (docs-h1-positions html)))
    (unless positions (error "The guide has no top-level Org headings."))
    (loop for position in positions
          for next in (append (rest positions) (list (length html)))
          collect
          (let* ((tag-end (position #\> html :start position))
                 (tag (subseq html position (1+ tag-end)))
                 (title-end (search "</h1>" html :start2 (1+ tag-end)))
                 (title (docs-strip-tags (subseq html (1+ tag-end) title-end))))
            (list :slug (docs-attribute tag "id")
                  :title title :body (subseq html position next))))))

(defun docs-page (title body &key slug breadcrumb index-p)
  (format nil "<!DOCTYPE html>
<html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
<title>~A · Autolith docs · Lambda Symbolics OÜ</title><meta name=\"description\" content=\"~A\">
<link rel=\"canonical\" href=\"~A\"><link rel=\"icon\" href=\"~A\" type=\"image/svg+xml\"><link rel=\"stylesheet\" href=\"~A\"></head>
<body><a class=\"skip-link\" href=\"#main-content\">Skip to content</a>
<header class=\"shell\"><div class=\"letterhead\"><a class=\"wordmark\" href=\"/\"><img src=\"/logo/ls-wordmark.svg\" alt=\"Lambda Symbolics\" width=\"110\" height=\"31\"></a><nav class=\"site-nav\" aria-label=\"Primary\"><ul class=\"site-nav-list\"><li><a href=\"/autolith\">Autolith</a></li><li><a href=\"/autolith/docs\">Docs</a></li><li><a href=\"https://github.com/lambda-symbolics/autolith\">GitHub</a></li></ul></nav></div></header>
<main id=\"main-content\" class=\"shell doc-page\">~A~A</main>
<footer class=\"shell\"><div class=\"colophon\"><p>© 2026 Lambda Symbolics OÜ · <a href=\"/lukas\">me</a></p><p>Autolith docs · Revised ~A</p></div></footer></body></html>"
          title title (docs-url (or slug "")) *docs-favicon* *paper-css-url*
          (if index-p body breadcrumb) (if index-p "" body) *docs-revised*))

(defun docs-toc (chapters current)
  (with-output-to-string (out)
    (format out "<aside class=\"doc-contents\"><div class=\"window\"><div class=\"window-titlebar\">Contents</div><div class=\"window-body\"><ol class=\"toc-list\">")
    (loop for chapter in chapters for number from 1
          for slug = (getf chapter :slug) for title = (getf chapter :title)
          do (if (string= slug current)
                 (format out "<li><span class=\"toc-current\"><span class=\"toc-number\">~D</span>~A</span></li>" number title)
                 (format out "<li><a href=\"~A\"><span class=\"toc-number\">~D</span>~A</a></li>" (docs-href slug) number title)))
    (write-string "</ol></div></div></aside>" out)))

(defun docs-pager (chapters index)
  (with-output-to-string (out)
    (format out "<nav class=\"docs-pager\" aria-label=\"Guide chapters\">")
    (when (> index 0)
      (let ((chapter (nth (1- index) chapters)))
        (format out "<div class=\"docs-pager-cell\"><span class=\"docs-pager-label\">Previous</span><a href=\"~A\">~A</a></div>" (docs-href (getf chapter :slug)) (getf chapter :title))))
    (when (< index (1- (length chapters)))
      (let ((chapter (nth (1+ index) chapters)))
        (format out "<div class=\"docs-pager-cell docs-pager-cell--next\"><span class=\"docs-pager-label\">Next</span><a href=\"~A\">~A</a></div>" (docs-href (getf chapter :slug)) (getf chapter :title))))
    (write-string "</nav>" out)))

(defun docs-write-chapter (chapters chapter index)
  (let* ((slug (getf chapter :slug))
         (breadcrumb (format nil "<nav class=\"docs-path\" aria-label=\"Location\"><a href=\"/autolith/docs\">Docs</a> · ~A</nav><div class=\"doc-body\"><div class=\"doc-content\">~A~A</div>~A</div>"
                             (getf chapter :title) (getf chapter :body)
                             (docs-pager chapters index) (docs-toc chapters slug))))
    (docs-write (docs-file slug) (docs-page (getf chapter :title) breadcrumb :slug slug :breadcrumb ""))))

(defun docs-write-index (chapters)
  (let ((body (with-output-to-string (out)
                (format out "<section class=\"doc-content\"><h1>Autolith guide</h1><p>The current manual is generated from the authoritative Autolith guide. Read it in order or start with a chapter.</p><ol>")
                (dolist (chapter chapters)
                  (format out "<li><a href=\"~A\">~A</a></li>" (docs-href (getf chapter :slug)) (getf chapter :title)))
                (write-string "</ol></section>" out))))
    (docs-write (docs-file "") (docs-page "Autolith guide" body :slug "" :index-p t))))

(defun docs-write-redirect (legacy target)
  (let ((url (docs-url target))
        (canonical (docs-url (subseq target 0 (position #\# target)))))
    (docs-write (docs-file legacy)
                (format nil "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta http-equiv=\"refresh\" content=\"0; url=~A\"><link rel=\"canonical\" href=\"~A\"><title>Autolith docs moved</title></head><body><p>This page moved to <a href=\"~A\">the current Autolith guide</a>.</p></body></html>" url canonical url))))

(defun docs-site-sitemap-entries ()
  "Retain existing sitemap entries outside the generated Autolith manual."
  (let ((xml (docs-read (merge-pathnames "sitemap.xml" *site-root*))))
    (loop with start = 0 and entries = nil
          for open = (search "<url>" xml :start2 start)
          while open
          do (let ((close (search "</url>" xml :start2 open)))
               (unless close (error "Incomplete sitemap entry at ~D." open))
               (let ((entry (subseq xml open (+ close 6))))
                 (unless (search "https://lambda-symbolics.com/autolith/docs" entry)
                   (push entry entries)))
               (setf start (+ close 6)))
          finally (return (nreverse entries)))))

(defun docs-write-sitemap (chapters)
  (docs-write (merge-pathnames "sitemap.xml" *site-root*)
              (with-output-to-string (out)
                (format out "<?xml version=\"1.0\" encoding=\"UTF-8\"?>~%<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">~%")
                (dolist (entry (docs-site-sitemap-entries))
                  (format out "~A~%" entry))
                (format out "<url><loc>~A</loc></url>~%" (docs-url ""))
                (dolist (chapter chapters) (format out "<url><loc>~A</loc></url>~%" (docs-url (getf chapter :slug))))
                (format out "</urlset>~%"))))

(defun make-docs ()
  "Render every current guide chapter and redirect every retained legacy URL."
  (let ((chapters (docs-chapters (docs-guide-html))))
    (docs-write-index chapters)
    (loop for chapter in chapters for index from 0 do (docs-write-chapter chapters chapter index))
    (dolist (redirect *legacy-redirects*) (docs-write-redirect (car redirect) (cdr redirect)))
    (docs-write-sitemap chapters)
    (format t "Rendered ~D guide chapters and ~D legacy redirects.~%" (length chapters) (length *legacy-redirects*))))
