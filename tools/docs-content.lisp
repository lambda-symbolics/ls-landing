;;;; Read and render the Lisp data used by the site guide.

(defparameter *docs-content-dir* (merge-pathnames "content/guide/" *site-root*))
(defparameter *docs-inline-tags* '(:a :b :br :code :em :i :kbd :span :strong :sub))
(defparameter *docs-block-tags*
  '(:div :h1 :h2 :h3 :li :ol :p :pre :table :tbody :td :th :thead :tr :ul))
(defparameter *docs-editable-tags* '(:h1 :h2 :h3 :li :p :td :th))

(define-condition docs-content-error (error)
  ((reason :initarg :reason :reader docs-content-error-reason))
  (:report (lambda (condition stream)
             (write-string (docs-content-error-reason condition) stream))))

(defun docs-invalid (message)
  "Reject an invalid guide fragment."
  (error 'docs-content-error :reason message))

(defun docs-html-escape (text stream &key attribute-p highlighted-p)
  "Escape text according to its HTML context, including imported code spans."
  (loop for character across text
        do (case character
             (#\& (write-string "&amp;" stream))
             (#\< (write-string "&lt;" stream))
             (#\> (write-string "&gt;" stream))
             (#\" (if (or attribute-p highlighted-p) (write-string "&quot;" stream) (write-char character stream)))
             (#\' (if highlighted-p (write-string "&#39;" stream) (write-char character stream)))
             (otherwise (write-char character stream)))))

(defun docs-render-title (nodes &key attribute-p)
  "Render just the escaped text of a heading for navigation or metadata."
  (with-output-to-string (out)
    (labels ((text (node)
               (cond ((stringp node) (docs-html-escape node out :attribute-p attribute-p))
                     ((eq (first node) :br) (write-char #\Space out))
                     (t (mapc #'text (cddr node))))))
      (mapc #'text nodes))))

(defun docs-link-p (value)
  "Accept HTTPS links, fragments, and ordinary site-relative paths."
  (and (notany (lambda (c) (or (<= (char-code c) 32) (char= c #\\))) value)
       (or (and (uiop:string-prefix-p "https://" value) (> (length value) 8))
           (uiop:string-prefix-p "#" value)
           (and (uiop:string-prefix-p "/" value)
                (not (uiop:string-prefix-p "//" value))))))

(defun docs-validate-node (node &key inline-only (depth 0))
  "Check the element and attribute vocabulary before rendering or saving."
  (when (> depth 32) (docs-invalid "Guide markup is nested too deeply."))
  (unless (stringp node)
    (unless (and (consp node)
                 (or (member (first node) *docs-inline-tags*)
                     (and (not inline-only) (member (first node) *docs-block-tags*)))
                 (consp (rest node)))
      (docs-invalid "Unsupported guide element."))
    (destructuring-bind (tag attributes &rest children) node
      (loop for (name value) on attributes by #'cddr
            unless (and (stringp value)
                        (if inline-only
                            (case name
                              (:href (and (eq tag :a) (docs-link-p value)))
                              ((:aria-hidden :class) t))
                            (case name
                              (:href (and (eq tag :a) (docs-link-p value)))
                              ((:aria-hidden :class :data-org-language :id :start :tabindex) t))))
              do (docs-invalid "Unsupported guide attribute or link."))
      (when (and (eq tag :br) children) (docs-invalid "A line break cannot have children."))
      (dolist (child children)
        (docs-validate-node child :inline-only inline-only :depth (1+ depth))))))

(defun docs-read-dispatch (stream character)
  "Disable reader dispatch syntax in non-executable guide data."
  (declare (ignore stream character))
  (docs-invalid "Reader dispatch syntax is not allowed in guide content."))

(defun docs-data-read (stream &key locations)
  "Read non-executable guide data, optionally recording each list's character span."
  (let ((*read-eval* nil)
        (*readtable* (copy-readtable nil)))
    (set-macro-character #\# #'docs-read-dispatch)
    (when locations
      (let ((read-list (get-macro-character #\()))
        (set-macro-character
         #\( (lambda (input character)
               (let* ((start (1- (file-position input)))
                      (node (funcall read-list input character)))
                 (when (consp node)
                   (setf (gethash node locations) (cons start (file-position input))))
                 node)))))
    (read stream nil ':eof)))

(defun docs-chapter-parse (text &key locations)
  "Read and validate the blocks of a chapter."
  (with-input-from-string (input text)
    (loop for node = (docs-data-read input :locations locations) until (eq node :eof)
          do (docs-validate-node node)
          collect node)))

(defun docs-chapter-read (path)
  "Read the chapter's UTF-8 copy from disk."
  (docs-chapter-parse (uiop:read-file-string path :external-format :utf-8)))

(defun docs-chapter-replace (path &key text span node)
  "Atomically replace one form without reformatting any neighboring copy."
  (uiop:with-temporary-file (:stream output :pathname temporary
                            :directory (uiop:pathname-directory-pathname path)
                            :external-format :utf-8 :keep t)
    (unwind-protect
         (progn
           (write-string text output :end (first span))
           (let ((*print-case* :downcase) (*print-pretty* nil))
             (prin1 node output))
           (write-string text output :start (rest span))
           (close output)
           (uiop:rename-file-overwriting-target temporary path))
      (when (probe-file temporary) (delete-file temporary)))))

(defun docs-chapter-path (slug)
  "Resolve a manifest-listed chapter slug to its data file."
  (merge-pathnames (concatenate 'string slug ".sexp") *docs-content-dir*))

(defun docs-chapter-slugs ()
  "Read the ordered list of chapter slugs."
  (with-open-file (input (merge-pathnames "index.sexp" *docs-content-dir*)
                         :external-format :utf-8)
    (let ((slugs (docs-data-read input)))
      (unless (and (consp slugs) (eq (docs-data-read input) :eof)
                   (every (lambda (slug)
                            (and (stringp slug) (plusp (length slug))
                                 (not (string= slug "index"))
                                 (every (lambda (c) (find c "abcdefghijklmnopqrstuvwxyz-0123456789")) slug)))
                          slugs)
                   (= (length slugs) (length (remove-duplicates slugs :test #'string=))))
        (docs-invalid "Invalid guide chapter manifest."))
      slugs)))

(defun docs-inline-node-p (node)
  "Whether NODE fits inside an editable inline region."
  (or (stringp node) (member (first node) *docs-inline-tags*)))

(defun docs-editable-node-p (node)
  "Choose text-bearing regions without nesting contenteditable fields."
  (and (consp node) (member (first node) *docs-editable-tags*)
       (every #'docs-inline-node-p (cddr node))))

(defun docs-render-nodes (nodes &key decorate)
  "Render guide nodes, optionally adding generated attributes to editable regions."
  (with-output-to-string (out)
    (let ((index 0))
        (labels ((render-node (node &optional highlighted-p)
                   (if (stringp node)
                       (docs-html-escape node out :highlighted-p highlighted-p)
                       (destructuring-bind (tag attributes &rest children) node
                         (let ((name (string-downcase (symbol-name tag)))
                               (highlighted-p (or highlighted-p
                                                  (and (eq tag :pre)
                                                       (uiop:string-prefix-p "sourceCode" (getf attributes :class ""))))))
                           (write-char #\< out)
                           (write-string name out)
                           (loop for (key value) on attributes by #'cddr
                                 do (format out " ~(~A~)=\"" key)
                                    (docs-html-escape value out :attribute-p t)
                                    (write-char #\" out))
                           (when (and decorate (docs-editable-node-p node))
                             (funcall decorate out index node)
                             (incf index))
                           (write-char #\> out)
                           (unless (eq tag :br)
                             (dolist (child children) (render-node child highlighted-p))
                             (format out "</~A>" name)))))))
        (loop for node in nodes do (render-node node) (terpri out))))))

(defun docs-find-editable-node (nodes index)
  "Locate INDEX in the same preorder the chapter renderer uses."
  (labels ((visit (node)
             (when (consp node)
               (when (docs-editable-node-p node)
                 (when (zerop index) (return-from docs-find-editable-node node))
                 (decf index))
               (mapc #'visit (cddr node)))))
    (mapc #'visit nodes)
    nil))
