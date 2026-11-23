;;;; Run the private Autolith guide editor with SBCL and Quicklisp.

(require :asdf)
(require :sb-md5)
(asdf:initialize-source-registry '(:source-registry :ignore-inherited-configuration))
(pushnew :hunchentoot-no-ssl *features*)
(load (or (uiop:getenv "QUICKLISP_SETUP") (merge-pathnames "quicklisp/setup.lisp" (user-homedir-pathname))))
(ql:quickload :hunchentoot :silent t)
(load (merge-pathnames "make-docs.lisp" *load-truename*))

(defclass docs-editor (hunchentoot:acceptor) ()
  (:documentation "Local preview and copy editing for the site guide."))

(defvar *docs-save-lock* (sb-thread:make-mutex :name "Guide copy writes"))

(defun docs-edit-revision (node)
  "Return a stable revision for the exact fragment rendered to the browser."
  (let ((digest (sb-md5:md5sum-string (docs-render-nodes (list node)) :external-format :utf-8)))
    (format nil "~(~{~2,'0X~}~)" (coerce digest 'list))))

(defun docs-edit-decorator (slug)
  "Add editing metadata without changing the underlying chapter markup."
  (lambda (out index node)
    (format out " data-edit=\"~A/~D\" data-revision=\"~A\"" slug index (docs-edit-revision node))))

(defun docs-edit-value (text)
  "Parse one posted list of inline nodes as non-executable data."
  (with-input-from-string (input text)
    (let ((value (docs-data-read input)))
      (unless (and (listp value) (eq (docs-data-read input) :eof))
        (docs-invalid "Expected one list of inline nodes."))
      (dolist (node value) (docs-validate-node node :inline-only t))
      value)))

(defun docs-edit-save (key revision value)
  "Save one fragment, comparing its revision under the write lock."
  (let* ((slash (position #\/ key))
         (slug (when slash (subseq key 0 slash)))
         (index (when (and slash (< slash (1- (length key)))
                           (every (lambda (c) (find c "0123456789")) (subseq key (1+ slash))))
                  (parse-integer key :start (1+ slash)))))
    (unless (and index (member slug (docs-chapter-slugs) :test #'string=))
      (return-from docs-edit-save (values 404 "No such guide fragment.")))
    (let ((children (docs-edit-value value))
          (path (docs-chapter-path slug)))
      (sb-thread:with-mutex (*docs-save-lock*)
        (let* ((text (docs-read path))
               (locations (make-hash-table :test #'eq))
               (nodes (docs-chapter-parse text :locations locations))
               (node (docs-find-editable-node nodes index)))
          (unless (and node (string= revision (docs-edit-revision node)))
            (return-from docs-edit-save (values 409 "This fragment changed on disk. Reload before editing it again.")))
          (setf (cddr node) children)
          (docs-chapter-replace path :text text :span (gethash node locations) :node node)
          (values 200 (docs-edit-revision node)))))))

(defun docs-edit-reply (status message &optional (type "text/plain; charset=utf-8"))
  "Return a non-cacheable private editor response."
  (setf (hunchentoot:return-code*) status
        (hunchentoot:content-type*) type)
  message)

(defun docs-edit-authority (acceptor)
  "Return the expected HTTP authority for the configured interface."
  (format nil "~A:~D" (hunchentoot:acceptor-address acceptor) (hunchentoot:acceptor-port acceptor)))

(defun docs-edit-post ()
  "Accept only same-origin browser saves with an explicit editor header."
  (let ((expected (concatenate 'string "http://" (docs-edit-authority hunchentoot:*acceptor*))))
    (unless (and (equal (hunchentoot:header-in* :origin) expected)
                 (equal (hunchentoot:header-in* :x-docs-edit) "1"))
      (return-from docs-edit-post (docs-edit-reply 403 "Open the editor directly to save changes."))))
  (let ((key (hunchentoot:post-parameter "copy"))
        (revision (hunchentoot:post-parameter "revision"))
        (value (hunchentoot:post-parameter "value")))
    (unless (and key (<= (length key) 100) revision (= (length revision) 32)
                 value (<= (length value) 32768))
      (return-from docs-edit-post (docs-edit-reply 400 "Invalid copy request.")))
    (handler-case
        (multiple-value-bind (code text) (docs-edit-save key revision value)
          (docs-edit-reply code text))
      (docs-content-error (condition) (docs-edit-reply 400 (princ-to-string condition)))
      (reader-error () (docs-edit-reply 400 "Invalid Lisp data."))
      (end-of-file () (docs-edit-reply 400 "Incomplete Lisp data."))
      (type-error () (docs-edit-reply 400 "Expected a list of valid inline nodes.")))))

(defun docs-edit-page (path)
  "Serve the index or one of the manifest-listed chapter pages."
  (let ((chapters (docs-chapters))
        (type "text/html; charset=utf-8"))
    (cond
      ((member path '("/autolith/docs" "/autolith/docs/") :test #'string=)
       (docs-edit-reply 200 (docs-index-page chapters :edit-p t) type))
      (t
       (loop for chapter in chapters for index from 0
             for slug = (getf chapter :slug)
             when (string= path (docs-href slug))
               return (docs-edit-reply 200 (docs-chapter-page chapters chapter index :decorate (docs-edit-decorator slug)) type)
             finally (return (docs-edit-reply 404 "No such guide page.")))))))

(defmethod hunchentoot:acceptor-dispatch-request ((acceptor docs-editor) request)
  "Serve only guide pages and explicitly listed assets."
  (let* ((path (hunchentoot:script-name request))
         (method (hunchentoot:request-method request))
         (asset (assoc path '(("/paper.css" . "paper.css")
                              ("/logo/ls-wordmark.svg" . "logo/ls-wordmark.svg")
                              ("/logo/ls-favicon.svg" . "logo/ls-favicon.svg")
                              ("/edit/editor.css" . "tools/docs-editor/editor.css")
                              ("/edit/editor.js" . "tools/docs-editor/editor.js")) :test #'string=)))
    (when (and (uiop:string-prefix-p "/fonts/" path)
               (let ((name (subseq path 7)))
                 (and (every (lambda (c) (find c "abcdefghijklmnopqrstuvwxyz0123456789-.")) name)
                      (or (uiop:string-suffix-p name ".woff2") (uiop:string-suffix-p name ".ttf"))
                      (probe-file (merge-pathnames (subseq path 1) *site-root*)))))
      (setf asset (cons path (subseq path 1))))
    (setf (hunchentoot:header-out :cache-control) "no-store"
          (hunchentoot:header-out :x-content-type-options) "nosniff"
          (hunchentoot:header-out :x-frame-options) "DENY")
    (cond
      ((not (equal (hunchentoot:header-in* :host) (docs-edit-authority acceptor)))
       (docs-edit-reply 403 "Use the editor's configured address."))
      ((and (eq method :post) (string= path "/copy")) (docs-edit-post))
      ((not (member method '(:get :head))) (docs-edit-reply 405 "Method not allowed."))
      ((member path '("/" "/autolith") :test #'string=) (hunchentoot:redirect "/autolith/docs"))
      (asset (hunchentoot:handle-static-file (merge-pathnames (cdr asset) *site-root*)
                                           (when (string= path "/edit/editor.js") "text/javascript; charset=utf-8")))
      ((or (uiop:string-prefix-p "/autolith/docs/" path) (string= path "/autolith/docs"))
       (docs-edit-page path))
      (t (docs-edit-reply 404 "No such editor route.")))))

(defun docs-editor-run (&key (address "127.0.0.1") (port 7778))
  "Start the private IPv4 editor and keep serving until interrupted."
  (let ((octets (uiop:split-string address :separator '(#\.))))
    (unless (and (= (length octets) 4)
                 (every (lambda (part)
                          (and (<= 1 (length part) 3) (every #'digit-char-p part)
                               (<= 0 (parse-integer part) 255)
                               (string= part (write-to-string (parse-integer part))))) octets)
                 (member (first octets) '("127" "10" "172" "192") :test #'string=)
                 (or (member (first octets) '("127" "10") :test #'string=)
                     (and (string= (first octets) "172") (<= 16 (parse-integer (second octets)) 31))
                     (and (string= (first octets) "192") (string= (second octets) "168"))))
      (error "Bind the editor to a loopback or private IPv4 address.")))
  (let ((acceptor (make-instance 'docs-editor :address address :port port)))
    (docs-chapters)
    (hunchentoot:start acceptor)
    (format t "Docs editor: http://~A:~D/autolith/docs~%" address port)
    (finish-output)
    (unwind-protect (loop (sleep 3600)) (hunchentoot:stop acceptor))))

(destructuring-bind (&optional (address "127.0.0.1") (port "7778")) (uiop:command-line-arguments)
  (docs-editor-run :address address :port (parse-integer port)))
