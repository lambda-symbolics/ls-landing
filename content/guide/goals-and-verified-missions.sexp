(:h1 (:id "goals-and-verified-missions") "Goals and verified missions")

(:p nil "Use a " (:strong nil "goal") " for work that can continue between messages. Use a " (:strong nil "mission") " if you want to define acceptance criteria, checks, and a budget before work begins.")

(:h2 (:id "goals") "Set a goal")

(:ol nil (:li nil "Run " (:code nil "(goal \"OBJECTIVE\")") " to set the objective.")
 (:li nil "Run " (:code nil "(goal)") " to check progress. Use " (:code nil "(goal :pause)")
  " to pause, or " (:code nil "(goal :resume)") " to continue."))

(:p nil
 "By default, a goal pauses after eight automatic turns without a new message from you. Change this limit with "
 (:code nil "(settings :goal-continuation-limit N)") ".")

(:h2 (:id "start-a-mission") "Start and verify a mission")

(:ol nil
  "
"
  (:li nil (:p nil "Install the objective, limits, and acceptance criteria with " (:code (:class "verbatim") "(mission :start specification)") ". This example requires both a passing build and your review:") "
" (:div (:class "window code-window")
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
        (:div (:class "sourceCode" :id "cb49" :data-org-language "lisp")
          (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb49-1") (:a (:href "#cb49-1" :aria-hidden "true" :tabindex "-1")) "(mission " (:span (:class "bu") ":start")) "
" (:span (:id "cb49-2") (:a (:href "#cb49-2" :aria-hidden "true" :tabindex "-1")) " '(:objective " (:span (:class "st") "\"Deliver the accepted build\"")) "
" (:span (:id "cb49-3") (:a (:href "#cb49-3" :aria-hidden "true" :tabindex "-1")) "   :turn-limit " (:span (:class "dv") "40") " :token-limit " (:span (:class "dv") "100000") " :wall-seconds " (:span (:class "dv") "3600")) "
" (:span (:id "cb49-4") (:a (:href "#cb49-4" :aria-hidden "true" :tabindex "-1")) "   :criteria ((:id " (:span (:class "st") "\"build\"") " :description " (:span (:class "st") "\"The build passes\"") " :gates (" (:span (:class "st") "\"build\"") "))") "
" (:span (:id "cb49-5") (:a (:href "#cb49-5" :aria-hidden "true" :tabindex "-1")) "              (:id " (:span (:class "st") "\"review\"") " :description " (:span (:class "st") "\"The user accepts the result\"") "))") "
" (:span (:id "cb49-6") (:a (:href "#cb49-6" :aria-hidden "true" :tabindex "-1")) "   :gates ((:id " (:span (:class "st") "\"build\"") " :kind :command :command " (:span (:class "st") "\"make check\"")) "
" (:span (:id "cb49-7") (:a (:href "#cb49-7" :aria-hidden "true" :tabindex "-1")) "            :inputs (" (:span (:class "st") "\"Makefile\"") " " (:span (:class "st") "\"src/main.lisp\"") ") :deterministic-p " (:span (:class "kw") "t")) "
" (:span (:id "cb49-8") (:a (:href "#cb49-8" :aria-hidden "true" :tabindex "-1")) "            :attempt-limit " (:span (:class "dv") "3") " :timeout-seconds " (:span (:class "dv") "300") "))))"))))
        "
")
      "
"))
  "
"
  (:li nil (:p nil "Run " (:code (:class "verbatim") "(mission :run)") " and inspect the saved state with " (:code (:class "verbatim") "(mission :status)") "."))
  "
"
  (:li nil (:p nil "Give explicit evidence for each criterion without a gate. If the mission is blocked on your review, accept the result and resume:") "
" (:div (:class "window code-window")
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
        (:div (:class "sourceCode" :id "cb50" :data-org-language "lisp")
          (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb50-1") (:a (:href "#cb50-1" :aria-hidden "true" :tabindex "-1")) "(mission :accept " (:span (:class "st") "\"review\"") " " (:span (:class "st") "\"I inspected the artifact and accept the result\"") ")") "
" (:span (:id "cb50-2") (:a (:href "#cb50-2" :aria-hidden "true" :tabindex "-1")) "(mission :resume)"))))
        "
")
      "
"))
  "
"
  (:li nil (:p nil "Request verification with " (:code (:class "verbatim") "(mission :verify)") ". The model can also request it with its completion marker. A mission is verified only if every gate passes and every criterion is satisfied."))
  "
")

(:p nil "Give each criterion a unique " (:code (:class "verbatim") ":id") " and a " (:code (:class "verbatim") ":description") ". Use " (:code (:class "verbatim") ":gates") " to list the checks that count as evidence for that criterion. The model cannot weaken the criteria or accept results on your behalf. Only the primary agent can use the " (:code (:class "verbatim") "mission.status") ", " (:code (:class "verbatim") "mission.verify") ", " (:code (:class "verbatim") "mission.stop") ", and " (:code (:class "verbatim") "mission.invalidate") " tools.")

(:h2 (:id "mission-budgets") "Set a budget")

(:p nil "Mission budgets cover work by the primary agent and by child agents.")

(:ul nil (:li nil (:strong nil "Turns.") " Set " (:code nil ":turn-limit") " to cap provider calls.")
 (:li nil (:strong nil "Tokens.") " Set " (:code nil ":token-limit")
  " to cap model usage. This is not a billing limit.")
 (:li nil (:strong nil "Time.") " Set " (:code nil ":wall-seconds")
  " to set a deadline. It includes time spent paused."))

(:p nil "Autolith pauses new inference if it cannot account for missing usage. Set "
 (:code nil ":unknown-usage-policy :record")
 " at the start of the mission if you want work to continue with those gaps recorded.")

(:ul nil
 (:li nil "Pause with " (:code nil "(goal :pause)") " and resume with "
  (:code nil "(mission :resume)") ". These commands do not reset the budget.")
 (:li nil "Cancel with " (:code nil "(mission :cancel)") "."))

(:h2 (:id "mission-gates") "Choose checks for acceptance")

(:p nil "Gates run in order and stop at the first failure:")

(:ul nil
  "
"
  (:li nil (:strong nil "Command gates") " use the normal shell authorization and sandbox boundary.")
  "
"
  (:li nil (:strong nil "Artifact gates") " require " (:code (:class "verbatim") ":path") ". Set " (:code (:class "verbatim") ":sha256") " to check an expected hash.")
  "
"
  (:li nil (:strong nil "Lisp gates") " require a " (:code (:class "verbatim") ":predicate") " string. The assertion runs in the existing isolated Lisp worker.")
  "
")

(:p nil "Use " (:code nil ":timeout-seconds") " and " (:code nil ":attempt-limit")
 " to set the time and attempts for each check.")

(:p nil "For checks that depend on files, use " (:code nil ":deterministic-p t")
 " and list all relevant files in " (:code nil ":inputs")
 ". For checks that depend on remote state, run the check again after the remote state changes:")

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
    (:div (:class "sourceCode" :id "cb52" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb52-1") (:a (:href "#cb52-1" :aria-hidden "true" :tabindex "-1")) "(mission :invalidate " (:span (:class "st") "\"build\"") " " (:span (:class "st") "\"The remote build configuration changed\"") ")"))))
    "
")
  "
")

(:p nil "Invalidating a check allows it to run again if there are attempts left in the budget.")

(:h2 (:id "independent-review-checkpoints") "Independent review checkpoints")

(:p nil "Attach a reviewer to an active mission with " (:code (:class "verbatim") "mission-review.configure") ", or evaluate:")

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
    (:div (:class "sourceCode" :id "cb53" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb53-1") (:a (:href "#cb53-1" :aria-hidden "true" :tabindex "-1")) "(application-mission-review-configure") "
" (:span (:id "cb53-2") (:a (:href "#cb53-2" :aria-hidden "true" :tabindex "-1")) " *active-application*") "
" (:span (:id "cb53-3") (:a (:href "#cb53-3" :aria-hidden "true" :tabindex "-1")) " '(:id " (:span (:class "st") "\"release-review\"") " :phase :final-acceptance") "
" (:span (:id "cb53-4") (:a (:href "#cb53-4" :aria-hidden "true" :tabindex "-1")) "   :inputs (" (:span (:class "st") "\"src/main.lisp\"") " " (:span (:class "st") "\"tests/main-tests.lisp\"") ")") "
" (:span (:id "cb53-5") (:a (:href "#cb53-5" :aria-hidden "true" :tabindex "-1")) "   :context " (:span (:class "st") "\"Review the changed behavior and test coverage. Report concrete findings.\"")) "
" (:span (:id "cb53-6") (:a (:href "#cb53-6" :aria-hidden "true" :tabindex "-1")) "   :turn-limit " (:span (:class "dv") "4") " :token-limit " (:span (:class "dv") "16000") " :run-limit " (:span (:class "dv") "3") "))"))))
    "
")
  "
")

(:p nil "List the files that the reviewer should inspect in " (:code nil ":inputs") ". Set "
 (:code nil ":run-limit") " to cap the number of changed snapshots reviewed.")

(:ul nil
 (:li nil "Run a checkpoint with " (:code nil "mission-review.trigger") " and the checkpoint ID.")
 (:li nil "Read the findings with " (:code nil "mission-review.inspect") ".")
 (:li nil "Use " (:code nil "mission-review.decide")
  " to resolve or reject each finding. Give evidence for the decision."))

(:p nil
 "Final verification runs the checkpoints configured for final acceptance. Resolve outstanding findings and retry interrupted reviews before acceptance.")

(:h2 (:id "scheduled-mission-continuations") "Scheduled mission continuations")

(:p nil "Use " (:code nil "mission-schedule.add")
 " to schedule a continuation. Give the schedule a unique ID and say what Autolith should do. Choose one trigger:")

(:ul nil (:li nil (:code nil ":at") " sets a date and time in Common Lisp universal time.")
 (:li nil (:code nil ":interval") " sets an interval in seconds.")
 (:li nil (:code nil ":event") " names an external event."))

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
    (:div (:class "sourceCode" :id "cb54" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb54-1") (:a (:href "#cb54-1" :aria-hidden "true" :tabindex "-1")) "(application-mission-schedule-add") "
" (:span (:id "cb54-2") (:a (:href "#cb54-2" :aria-hidden "true" :tabindex "-1")) " *active-application* :id " (:span (:class "st") "\"build-followup\"")) "
" (:span (:id "cb54-3") (:a (:href "#cb54-3" :aria-hidden "true" :tabindex "-1")) " :content " (:span (:class "st") "\"Check the pending build and continue the mission.\"")) "
" (:span (:id "cb54-4") (:a (:href "#cb54-4" :aria-hidden "true" :tabindex "-1")) " :at (" (:span (:class "op") "+") " (" (:span (:class "kw") "get-universal-time") ") " (:span (:class "dv") "300") ") :missed-policy :latest)"))))
    "
")
  "
")

(:p nil "For recurring schedules, select a missed policy:")

(:ul nil (:li nil (:code nil "latest") " runs the newest missed occurrence. This is the default.")
 (:li nil (:code nil "all") " runs every missed occurrence.")
 (:li nil (:code nil "skip") " skips missed occurrences."))

(:p nil
 "A time schedule pauses automatic goal turns between occurrences. You can still send a message. Scheduled work uses the existing mission budget.")

(:p nil
 "Occurrences that come due while the mission is paused or blocked are skipped. After you resume, the next occurrence runs at the scheduled time.")

(:ul nil
 (:li nil "Use " (:code nil "mission-schedule.inspect") " to see pending or skipped occurrences.")
 (:li nil "Use " (:code nil "mission-schedule.cancel")
  " with the schedule ID to cancel future work."))

(:p nil "If scheduled work stopped partway through, check what it did before you retry. Use "
 (:code nil "mission-schedule.resolve") " to record the outcome or request a retry.")
