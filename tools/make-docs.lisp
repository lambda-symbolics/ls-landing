;;;; Generate the public Autolith manual from content/guide/*.sexp.
;;;
;;; sbcl --non-interactive --load tools/make-docs.lisp --eval '(make-docs)'

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :asdf))

(defparameter *site-root*
  (uiop:pathname-parent-directory-pathname
   (truename (or *load-pathname* *compile-file-pathname*))))
(defparameter *docs-dir* (merge-pathnames "autolith/docs/" *site-root*))
(load (merge-pathnames "tools/docs-content.lisp" *site-root*))
(defparameter *docs-revised* "23 November 2026")
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
     ("intro" . "first-session")
     ("onboarding" . "first-session#onboarding")
     ("command-arguments" . "talk-to-autolith#command-arguments")
     ("fullscreen-terminal" . "talk-to-autolith#read-the-transcript")
     ("terminal-diagrams" . "talk-to-autolith#terminal-diagrams")
     ("workspace" . "talk-to-autolith#exporting-and-importing-data")
     ("tools" . "connect-development-tools")
     ("lisp-workers" . "customise-autolith")
     ("live-image" . "generations-and-recovery")
     ("commits-and-recovery" . "generations-and-recovery")
     ("state" . "generations-and-recovery")
     ("recursive-inference" . "manage-context")
     ("agents-and-jobs" . "manage-tasks")
     ("providers" . "models-and-providers")
     ("mcp" . "connect-development-tools#connect-mcp")
     ("skills" . "customise-autolith#executable-skills")
     ("commands" . "customise-autolith#commands")
     ("cookbook/resume-and-replay" . "generations-and-recovery")
     ("cookbook/persist-a-function" . "customise-autolith#live-definitions")
     ("cookbook/search-big-corpus" . "manage-context")
     ("cookbook/run-from-ci" . "non-interactive-jobs")
     ("cookbook/add-mcp-server" . "connect-development-tools#connect-mcp")
     ("cookbook/project-setup" . "configure-autolith#configuration-files")
     ("advanced/management-endpoint" . "customise-autolith#active-image-management-endpoint")
     ("advanced/context-tuning" . "manage-context#output-limits-and-admission")))

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

(defun docs-chapters ()
  "Read the guide chapters in manifest order."
  (loop for slug in (docs-chapter-slugs)
        for nodes = (docs-chapter-read (docs-chapter-path slug))
        for heading = (first nodes)
        collect
        (progn
          (unless (and (consp heading) (eq (first heading) :h1)
                       (equal (getf (second heading) :id) slug))
            (docs-invalid (format nil "Chapter ~A needs a matching top-level heading." slug)))
          (list :slug slug :title (docs-render-title (cddr heading))
                :description (docs-render-title (cddr heading) :attribute-p t)
                :nodes nodes))))

(defun docs-page (title body &key slug edit-p (description title))
  (format nil "<!DOCTYPE html>
<html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
<title>~A · Autolith docs · Lambda Symbolics OÜ</title><meta name=\"description\" content=\"~A\">
<link rel=\"canonical\" href=\"~A\"><link rel=\"icon\" href=\"~A\" type=\"image/svg+xml\"><link rel=\"stylesheet\" href=\"~A\">~A</head>
<body><a class=\"skip-link\" href=\"#main-content\">Skip to content</a>
<header class=\"shell\"><div class=\"letterhead\"><a class=\"wordmark\" href=\"/\"><img src=\"/logo/ls-wordmark.svg\" alt=\"Lambda Symbolics\" width=\"110\" height=\"31\"></a><nav class=\"site-nav\" aria-label=\"Primary\"><ul class=\"site-nav-list\"><li><a href=\"/autolith\">Autolith</a></li><li><a href=\"/autolith/docs\">Docs</a></li><li><a href=\"https://github.com/lambda-symbolics/autolith\">GitHub</a></li></ul></nav></div></header>
<main id=\"main-content\" class=\"shell doc-page\">~A</main>
<footer class=\"shell\"><div class=\"colophon\"><p>© 2026 Lambda Symbolics OÜ · <a href=\"/lukas\">me</a></p><p>Autolith docs · Revised ~A</p></div></footer></body></html>"
          title description (docs-url (or slug "")) *docs-favicon* *paper-css-url*
          (if edit-p "<link rel=\"stylesheet\" href=\"/edit/editor.css\"><script type=\"module\" src=\"/edit/editor.js\"></script>" "")
          body *docs-revised*))

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

(defun docs-chapter-page (chapters chapter index &key decorate)
  "Render a chapter page using the same template for publishing and editing."
  (let* ((slug (getf chapter :slug))
         (body (format nil "<nav class=\"docs-path\" aria-label=\"Location\"><a href=\"/autolith/docs\">Docs</a> · ~A</nav><div class=\"doc-body\"><div class=\"doc-content\">~A~A</div>~A</div>"
                       (getf chapter :title)
                       (docs-render-nodes (getf chapter :nodes) :decorate decorate)
                       (docs-pager chapters index) (docs-toc chapters slug))))
    (docs-page (getf chapter :title) body :slug slug :edit-p decorate
               :description (getf chapter :description))))

(defun docs-index-page (chapters &key edit-p)
  "Render the chapter index."
  (let ((body (with-output-to-string (out)
                (write-string "<section class=\"doc-content\"><h1>Autolith guide</h1><ul>" out)
                (dolist (chapter chapters)
                  (format out "<li><a href=\"~A\">~A</a></li>" (docs-href (getf chapter :slug)) (getf chapter :title)))
                (write-string "</ul></section>" out))))
    (docs-page "Autolith guide" body :edit-p edit-p)))

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
  (let ((chapters (docs-chapters)))
    (docs-write (docs-file "") (docs-index-page chapters))
    (loop for chapter in chapters for index from 0
          do (docs-write (docs-file (getf chapter :slug)) (docs-chapter-page chapters chapter index)))
    (dolist (redirect *legacy-redirects*) (docs-write-redirect (car redirect) (cdr redirect)))
    (docs-write-sitemap chapters)
    (format t "Rendered ~D guide chapters and ~D legacy redirects.~%" (length chapters) (length *legacy-redirects*))))
