(:h1 (:id "non-interactive-jobs") "Non-interactive jobs")

(:p nil "Use " (:code (:class "verbatim") "run-job") " to run one child role from a script or CI. It uses the configured providers, MCP servers and role policies. Read the result from " (:code (:class "verbatim") "--output") ". Choose exactly one input form: " (:code (:class "verbatim") "--input FILE") " or " (:code (:class "verbatim") "--prompt TEXT") ".")

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

(:p nil "Autolith atomically publishes an " (:code (:class "verbatim") "(:autolith-job-result :version 1 ...)") " artifact. Read " (:code (:class "verbatim") ":result") " for the response on " (:code (:class "verbatim") ":succeeded") ". Other terminal statuses are " (:code (:class "verbatim") ":failed") ", " (:code (:class "verbatim") ":cancelled") " and " (:code (:class "verbatim") ":timed-out") ". The result includes failure categories and any available trace and usage fields. Prompt read errors and oversized prompts produce a failure artifact too.")

(:p nil (:strong nil "Headless jobs cannot ask for approval.") " " (:code (:class "verbatim") "auto") " denies decisions that require a prompt. " (:code (:class "verbatim") "sandbox") " permits only sandboxed shell commands. " (:code (:class "verbatim") "full") " permits full command execution and external tools that otherwise require a prompt. The child role still controls which tools it can call.")

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

(:ul nil
  "
"
  (:li nil "Sequence numbers increase within one run. A new run starts at one with a new run ID. There is no replay or reconnect cursor.")
  "
"
  (:li nil "Event kinds are " (:code (:class "verbatim") ":run-started") ", " (:code (:class "verbatim") ":job-started") ", " (:code (:class "verbatim") ":tool-started") ", " (:code (:class "verbatim") ":progress") ", " (:code (:class "verbatim") ":tool-finished") ", " (:code (:class "verbatim") ":job-finished") ", " (:code (:class "verbatim") ":usage") ", " (:code (:class "verbatim") ":warning") ", " (:code (:class "verbatim") ":progress-omitted") " and " (:code (:class "verbatim") ":run-finished") ". Ignore unknown kinds. Events report registered tool names and bounded metadata, without prompts, tool payloads or output.")
  "
"
  (:li nil "Root " (:code (:class "verbatim") ":job-finished") " and final " (:code (:class "verbatim") ":run-finished") " follow result publication. Published job events carry " (:code (:class "verbatim") ":result-uri") ". The final event reports " (:code (:class "verbatim") ":status") " and " (:code (:class "verbatim") ":published-p") ". It includes " (:code (:class "verbatim") ":output-path") " on publication. A write failure reports " (:code (:class "verbatim") ":category :result-publication-failed") " and exits nonzero.")
  "
"
  (:li nil "A slow reader can miss events. " (:code (:class "verbatim") ":progress-omitted") " counts omitted progress, and a " (:code (:class "verbatim") ":warning") " with " (:code (:class "verbatim") ":code :queue-full") " reports lifecycle overflow. Execution and result publication continue even if the stream disconnects.")
  "
")

(:p nil "From Lisp, pass " (:code (:class "verbatim") ":events :sexp") " and " (:code (:class "verbatim") ":event-output STREAM") " to " (:code (:class "verbatim") "run-job-run") ". Read records with " (:code (:class "verbatim") "run-job-event-read-stream") ", which returns " (:code (:class "verbatim") "nil") " at EOF. The reader accepts bounded data forms of up to 16 KiB of UTF-8 per record. Use UTF-8 for character streams. Binary streams receive UTF-8 octets.")
