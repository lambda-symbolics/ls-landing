(:h1 (:id "goals-and-verified-missions") "Goals and verified missions")

(:p nil "Use a " (:strong nil "goal") " for work that can continue between messages without a set budget. Start a "
 (:strong nil "mission") " if you want to set acceptance criteria, checks, or a budget before work begins.")

(:h2 (:id "goals") "Set a goal")

(:ol nil (:li nil "Run " (:code nil "(goal \"OBJECTIVE\")") " to set the objective.")
 (:li nil "Run " (:code nil "(goal)") " to check progress.")
 (:li nil "Run " (:code nil "(goal :pause)") " to pause, " (:code nil "(goal :resume)")
  " to continue, or " (:code nil "(goal :clear)") " to clear the goal."))

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
  (:li nil (:p nil "Run " (:code nil "(mission :verify)") " to check the result. All checks must pass and all criteria must be met before the mission is marked as verified."))
  "
")

(:p nil "Give each criterion a unique " (:code nil ":id") " and a " (:code nil ":description")
 ". Use " (:code nil ":gates") " to list the checks for that criterion. For criteria that require your review, accept the result yourself.")

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
 (:li nil "Pause with " (:code nil "(mission :pause)") " and resume with "
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

(:h2 (:id "independent-review-checkpoints") "Ask for an independent review")

(:p nil "You can require a separate review before final verification. Tell Autolith which files to review and what the reviewer should check. Read the findings and resolve them before you accept the result.")

(:h2 (:id "scheduled-mission-continuations") "Schedule a follow-up")

(:p nil "Tell Autolith what to do next and when to do it. For example, ask it to check a pending build in five minutes and continue the mission if the build passes. Scheduled work uses the same mission budget. If you pause a mission, any follow-ups due during the pause are skipped.")
