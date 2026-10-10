#!/usr/bin/env sbcl --script
(require :asdf)

(defun layout-check-write-fixture (stylesheet stream)
  "Write rendered window-to-content cases using STYLESHEET to STREAM."
  (format stream "<!doctype html><html><head><meta charset='UTF-8'>~%<base href='file://~A'><style>~%~A~%</style>~%"
          (uiop:pathname-directory-pathname stylesheet)
          (uiop:read-file-string stylesheet))
  (write-string "<style>
body { padding: 24px; }
.fixture { display: flow-root; margin-bottom: 40px; }
.paired { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 32px; }
@media (max-width: 600px) { .paired { grid-template-columns: 1fr; } }
</style></head><body>
" stream)
  (dolist (following '("<p>Paragraph after a window.</p>"
                       "<ul><li>List after a window.</li></ul>"
                       "<button>Control after a window</button>"
                       "<span>Inline text after a window.</span>"))
    (format stream "<section class='fixture'><div class='window'><div class='window-titlebar'>Window</div><div class='window-body'>Window content.</div></div>~A</section>~%"
            following))
  (write-string "<section class='paired'>
<div class='window'><div class='window-titlebar'>First window</div><div class='window-body'>First content.</div></div>
<div class='window'><div class='window-titlebar'>Second window</div><div class='window-body'>Second content.</div></div>
</section>
<script>
const failures = [];
for (const fixture of document.querySelectorAll('.fixture')) {
  const window = fixture.querySelector('.window');
  const next = window.nextElementSibling;
  const frame = window.getBoundingClientRect();
  const shadow = getComputedStyle(window, '::after');
  const band = -parseFloat(shadow.bottom);
  const clearance = next.getBoundingClientRect().top - frame.bottom - band;
  if (!Number.isFinite(band) || band <= 0 || clearance < 4.99) {
    failures.push(next.tagName + ': shadow clearance ' + clearance + 'px');
  }
}
const [first, second] = [...document.querySelectorAll('.paired .window')].map(w => w.getBoundingClientRect());
const gap = second.top >= first.bottom ? second.top - first.bottom : second.left - first.right;
if (gap < 31.99) failures.push('Window-to-window gap: ' + gap + 'px');
document.body.dataset.windowLayout = failures.length ? 'failed' : 'passed';
const report = document.createElement('pre');
report.textContent = failures.length ? failures.join(String.fromCharCode(10)) : 'Window shadow clearance passed';
document.body.append(report);
</script></body></html>
" stream))

(defun layout-check-stylesheet (stylesheet browser)
  "Check painted window bounds at desktop and narrow widths in BROWSER."
  (uiop:with-temporary-file (:pathname fixture :stream stream :type "html")
    (layout-check-write-fixture stylesheet stream)
    (finish-output stream)
    (let ((profile (uiop:ensure-directory-pathname
                    (make-pathname :type "profile" :defaults fixture))))
      (unwind-protect
           (dolist (width '(1280 375))
             (multiple-value-bind (output diagnostics status)
                 (uiop:run-program
                  (list browser "--headless" "--no-sandbox" "--disable-gpu"
                        "--disable-dev-shm-usage" "--force-device-scale-factor=1"
                        (format nil "--user-data-dir=~A" profile)
                        (format nil "--window-size=~D,1000" width)
                        "--dump-dom" (format nil "file://~A" fixture))
                  :output :string :error-output :string :ignore-error-status t)
               (unless (and (zerop status)
                            (search "data-window-layout=\"passed\"" output))
                 (error "Window layout failed for ~A at ~Dpx:~%~A~%~A"
                        stylesheet width
                        (subseq output (max 0 (- (length output) 1200)))
                        (subseq diagnostics 0 (min (length diagnostics) 1200))))
               (format t "Window shadow clearance: ~A at ~Dpx passed.~%"
                       stylesheet width)))
        (when (probe-file profile)
          (uiop:delete-directory-tree profile :validate t))))))

(let* ((root (uiop:pathname-parent-directory-pathname
              (uiop:pathname-directory-pathname *load-truename*)))
       (stylesheets (or (uiop:command-line-arguments)
                        (list (merge-pathnames "paper.css" root))))
       (browser (or (uiop:getenv "CHROMIUM") "chromium")))
  (dolist (stylesheet stylesheets)
    (layout-check-stylesheet
     (uiop:ensure-absolute-pathname stylesheet *default-pathname-defaults*)
     browser)))
