(:h1 (:id "non-interactive-jobs") "Non-interactive jobs")

(:p nil "Use " (:code nil "autolith run-job") " to run a child role from a script or CI. Use "
 (:code nil "--input FILE") " for a job specification or " (:code nil "--prompt TEXT")
 " for a single assignment. Read the result from the file you set with " (:code nil "--output") ".")

(:div (:class "window code-window")
  "
"
  (:div (:class "window-titlebar")
    "
Shell
")
  "
"
  (:div (:class "window-body")
    "
"
    (:div (:class "sourceCode" :id "cb58" :data-org-language "sh")
      (:pre (:class "sourceCode bash") (:code (:class "sourceCode bash") (:span (:id "cb58-1") (:a (:href "#cb58-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " " (:span (:class "at") "--permissions") " auto run-job " (:span (:class "dt") "\\")) "
" (:span (:id "cb58-2") (:a (:href "#cb58-2" :aria-hidden "true" :tabindex "-1")) "  " (:span (:class "at") "--input") " /path/to/job.sexp " (:span (:class "dt") "\\")) "
" (:span (:id "cb58-3") (:a (:href "#cb58-3" :aria-hidden "true" :tabindex "-1")) "  " (:span (:class "at") "--output") " /path/to/result.sexp"))))
    "
")
  "
")

(:p nil "The input file contains one data-only form:")

(:div (:class "window code-window")
  "
"
  (:div (:class "window-titlebar")
    "
Common Lisp
")
  "
"
  (:div (:class "window-body")
    "
"
    (:div (:class "sourceCode" :id "cb59" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb59-1") (:a (:href "#cb59-1" :aria-hidden "true" :tabindex "-1")) "(:autolith-job") "
" (:span (:id "cb59-2") (:a (:href "#cb59-2" :aria-hidden "true" :tabindex "-1")) " " (:span (:class "bu") ":version") " " (:span (:class "dv") "1")) "
" (:span (:id "cb59-3") (:a (:href "#cb59-3" :aria-hidden "true" :tabindex "-1")) " :id " (:span (:class "st") "\"job-identifier\"")) "
" (:span (:id "cb59-4") (:a (:href "#cb59-4" :aria-hidden "true" :tabindex "-1")) " :role " (:span (:class "st") "\"project-role\"")) "
" (:span (:id "cb59-5") (:a (:href "#cb59-5" :aria-hidden "true" :tabindex "-1")) " :prompt " (:span (:class "st") "\"Perform the assigned work.\"")) "
" (:span (:id "cb59-6") (:a (:href "#cb59-6" :aria-hidden "true" :tabindex "-1")) " " (:span (:class "bu") ":input") " (:caller-owned " (:span (:class "st") "\"opaque data\"") ")") "
" (:span (:id "cb59-7") (:a (:href "#cb59-7" :aria-hidden "true" :tabindex "-1")) " :timeout-seconds " (:span (:class "dv") "900") ")"))))
    "
")
  "
")

(:p nil "For an inline assignment, pass " (:code (:class "verbatim") "--prompt TEXT") " or use " (:code (:class "verbatim") "--prompt -") " to read standard input. The defaults are role " (:code (:class "verbatim") "task") ", 86,400 seconds and a generated ID.")

(:div (:class "window code-window")
  "
"
  (:div (:class "window-titlebar")
    "
Shell
")
  "
"
  (:div (:class "window-body")
    "
"
    (:div (:class "sourceCode" :id "cb60" :data-org-language "sh")
      (:pre (:class "sourceCode bash") (:code (:class "sourceCode bash") (:span (:id "cb60-1") (:a (:href "#cb60-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " " (:span (:class "at") "--permissions") " auto run-job " (:span (:class "dt") "\\")) "
" (:span (:id "cb60-2") (:a (:href "#cb60-2" :aria-hidden "true" :tabindex "-1")) "  " (:span (:class "at") "--prompt") " " (:span (:class "st") "\"Review the current change and report the result.\"") " " (:span (:class "dt") "\\")) "
" (:span (:id "cb60-3") (:a (:href "#cb60-3" :aria-hidden "true" :tabindex "-1")) "  " (:span (:class "at") "--role") " task " (:span (:class "at") "--timeout-seconds") " 900 " (:span (:class "at") "--id") " review-change " (:span (:class "dt") "\\")) "
" (:span (:id "cb60-4") (:a (:href "#cb60-4" :aria-hidden "true" :tabindex "-1")) "  " (:span (:class "at") "--output") " /path/to/result.sexp"))))
    "
")
  "
")

(:p nil "Check the status in the output file. If the status is " (:code nil ":succeeded") ", read "
 (:code nil ":result") ". If the job failed, read the error in the same file.")

(:p nil
 "Choose the permission mode before you run the job. Headless jobs cannot prompt for approval.")

(:ul nil (:li nil (:code nil "auto") " denies operations that require approval.")
 (:li nil (:code nil "sandbox") " only permits sandboxed shell commands.")
 (:li nil (:code nil "full")
  " permits full command execution and external tools allowed by the role."))

(:h2 (:id "live-s-expression-events") "Live S-expression events")

(:p nil "Add " (:code (:class "verbatim") "--events sexp") " to observe progress on stdout. Send diagnostics to a separate stream, and use the artifact for the authoritative result:")

(:div (:class "window code-window")
  "
"
  (:div (:class "window-titlebar")
    "
Shell
")
  "
"
  (:div (:class "window-body")
    "
"
    (:div (:class "sourceCode" :id "cb61" :data-org-language "sh")
      (:pre (:class "sourceCode bash") (:code (:class "sourceCode bash") (:span (:id "cb61-1") (:a (:href "#cb61-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " " (:span (:class "at") "--permissions") " auto run-job " (:span (:class "dt") "\\")) "
" (:span (:id "cb61-2") (:a (:href "#cb61-2" :aria-hidden "true" :tabindex "-1")) "  " (:span (:class "at") "--input") " /path/to/job.sexp " (:span (:class "at") "--output") " /path/to/result.sexp " (:span (:class "dt") "\\")) "
" (:span (:id "cb61-3") (:a (:href "#cb61-3" :aria-hidden "true" :tabindex "-1")) "  " (:span (:class "at") "--events") " sexp " (:span (:class "op") ">") "events.sexp " (:span (:class "dv") "2") (:span (:class "op") ">") "diagnostics.log"))))
    "
")
  "
")

(:p nil "Read consecutive top-level forms. " (:em nil "Strings can contain newlines."))

(:div (:class "window code-window")
  "
"
  (:div (:class "window-titlebar")
    "
Common Lisp
")
  "
"
  (:div (:class "window-body")
    "
"
    (:div (:class "sourceCode" :id "cb62" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb62-1") (:a (:href "#cb62-1" :aria-hidden "true" :tabindex "-1")) "(:autolith-event " (:span (:class "bu") ":version") " " (:span (:class "dv") "1")) "
" (:span (:id "cb62-2") (:a (:href "#cb62-2" :aria-hidden "true" :tabindex "-1")) " :run-id " (:span (:class "st") "\"a-generated-run-uuid\"") " :seq " (:span (:class "dv") "1") " :time " (:span (:class "st") "\"2026-10-08T09:00:00Z\"")) "
" (:span (:id "cb62-3") (:a (:href "#cb62-3" :aria-hidden "true" :tabindex "-1")) " :kind :run-started :data " (:span (:class "kw") "nil") ")"))))
    "
")
  "
")

(:p nil
 "Use the output file to check the final status. A slow or disconnected event reader can miss events.")
