(:h1 (:id "goals-and-verified-missions") "Goals and verified missions")

(:p nil "Use a " (:strong nil "goal") " for work that can continue between messages. Use a " (:strong nil "mission") " if you want to define acceptance criteria, checks, and a budget before work begins.")

(:ul nil
  "
"
  (:li nil "Set a goal with " (:code (:class "verbatim") "(goal \"OBJECTIVE\")") ". A string such as " (:code (:class "verbatim") "\"pause\"") " is an objective, not an action.")
  "
"
  (:li nil "Inspect it with " (:code (:class "verbatim") "(goal)") " or " (:code (:class "verbatim") "(goal :status)") ". Change the objective with " (:code (:class "verbatim") "(goal :update \"NEW-OBJECTIVE\")") ".")
  "
"
  (:li nil "Pause, resume, or clear it with " (:code (:class "verbatim") "(goal :pause)") ", " (:code (:class "verbatim") "(goal :resume)") ", or " (:code (:class "verbatim") "(goal :clear)") ". An unknown action signals " (:code (:class "verbatim") "application-goal-error") " without changing the goal.")
  "
")

(:p nil "By default, a lightweight goal pauses after eight automatic continuation turns between user messages. Change the saved limit with " (:code (:class "verbatim") "(settings :goal-continuation-limit 16)") " or remove it with " (:code (:class "verbatim") "(settings :goal-continuation-limit :unlimited)") ".")

(:p nil "Queued commands and Lisp forms run between goal turns. The goal only continues if it yielded to the queued input. If you interrupt goal work, send a message to continue. A job can still wake the session after a goal finishes without restarting that goal.")

(:p nil "To set up and run a mission:")

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

(:p nil (:strong nil "Mission budgets") " cover parallel work as well as the primary agent:")

(:ul nil
  "
"
  (:li nil (:strong nil "Turns.") " Each provider call uses a turn, including calls from children, compaction, recursive inference, and independent review. Admissions and settlements are serialized within a mission. Provider calls can run in parallel.")
  "
"
  (:li nil (:strong nil "Tokens.") " Each admitted call reserves tokens from the unspent and unreserved budget. The default allocation divides them among the remaining turns. An explicit provider output cap replaces that allocation. On settlement, Autolith releases the reservation and charges reported input and output usage. Provider normalization excludes known prompt-cache reads. Measured usage can exhaust the budget.")
  "
"
  (:li nil (:strong nil "Wall time.") " The deadline includes gates, tools, pauses, and time away.")
  "
")

(:p nil "If a child call reports no usage, Autolith charges the full finite reservation once if it can identify the exact child and reservation. It records the failure and the unknown usage. The charge is already included in " (:code (:class "verbatim") ":tokens-used") ". Use " (:code (:class "verbatim") ":reservation-charged-tokens") " for the total and " (:code (:class "verbatim") ":reservation-charges-by-child") " for the breakdown. The child result lists " (:code (:class "verbatim") ":unknown-usage") ", " (:code (:class "verbatim") ":reservation-charged-tokens") ", and " (:code (:class "verbatim") ":reservation-charge-requests") ". The " (:code (:class "verbatim") ":usage") " field contains only measured usage.")

(:p nil "A reservation charge is an accounting rule, not a provider billing or output limit. Input and repeated generations can cost more. At the current library pin, Codex does not enforce an output ceiling on the wire. A successful retry charges the final reported usage without reconciling unreported attempts.")

(:p nil "The default " (:code (:class "verbatim") ":block") " policy blocks new inference if missing usage cannot be settled, including missing primary usage or uncertain child ownership. Already reserved requests and continuations that spend no tokens can finish. Restoring the session cannot recover per-request bounds from aggregate reservations or reclassify unresolved usage.")

(:p nil "To proceed despite missing usage, select " (:code (:class "verbatim") ":unknown-usage-policy :record") " when you start the mission:")

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
    (:div (:class "sourceCode" :id "cb51" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb51-1") (:a (:href "#cb51-1" :aria-hidden "true" :tabindex "-1")) "(mission " (:span (:class "bu") ":start")) "
" (:span (:id "cb51-2") (:a (:href "#cb51-2" :aria-hidden "true" :tabindex "-1")) " '(:objective " (:span (:class "st") "\"Run the periodic checks\"")) "
" (:span (:id "cb51-3") (:a (:href "#cb51-3" :aria-hidden "true" :tabindex "-1")) "   :turn-limit " (:span (:class "dv") "10000") " :token-limit " (:span (:class "dv") "10000000") " :wall-seconds " (:span (:class "dv") "86400")) "
" (:span (:id "cb51-4") (:a (:href "#cb51-4" :aria-hidden "true" :tabindex "-1")) "   :unknown-usage-policy :record") "
" (:span (:id "cb51-5") (:a (:href "#cb51-5" :aria-hidden "true" :tabindex "-1")) "   :criteria ((:id " (:span (:class "st") "\"checks\"") " :description " (:span (:class "st") "\"The user accepts the checks\"") "))))"))))
    "
")
  "
")

(:p nil "Under " (:code (:class "verbatim") ":record") ", Autolith records failed or interrupted calls whose usage cannot be settled and can continue without that measurement. It still charges exact child reservations if possible. Turn and wall-clock limits apply, and independent reviewers still need reported usage. To change the policy for existing work, start a new mission with the criteria and budgets and add the policy key. Large integer limits are finite.")

(:ul nil
  "
"
  (:li nil "Pause with " (:code (:class "verbatim") "(goal :pause)") " and resume with " (:code (:class "verbatim") "(mission :resume)") ". These commands do not reset the budget.")
  "
"
  (:li nil "Cancel with " (:code (:class "verbatim") "(mission :cancel \"REASON\")") ".")
  "
"
  (:li nil "Inspect a blocked mission with " (:code (:class "verbatim") "(mission :status)") ". Resolve the blocker before resuming. The terminal states are " (:code (:class "verbatim") "verified") ", " (:code (:class "verbatim") "exhausted") ", " (:code (:class "verbatim") "cancelled") ", and " (:code (:class "verbatim") "failed") ".")
  "
")

(:p nil "Autolith saves gate attempts, fingerprints, and evidence with the conversation so you can inspect them after a restore or compaction.")

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

(:p nil "Every gate supports " (:code (:class "verbatim") ":timeout-seconds") " and a separate " (:code (:class "verbatim") ":attempt-limit") ". The defaults are 60 seconds and three executions. Each gate keeps bounded evidence.")

(:p nil "For deterministic gates, declare all relevant file paths in " (:code (:class "verbatim") ":inputs") " and set " (:code (:class "verbatim") ":deterministic-p t") ". File contents and missing-file states form the fingerprint; directory paths are rejected. Unchanged passing gates supply current proof, and unchanged failed gates are withheld while the model works on their relevant inputs. For remote state, omit deterministic policy or invalidate a particular gate explicitly:")

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

(:p nil "Invalidation permits another execution without replenishing its attempt budget. Before acceptance, every gate fingerprint is checked again under the workspace mutation lock. Changes from a later gate invalidate earlier passing evidence. Collect terminal results and outstanding inference usage before verifying.")

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

(:p nil "Declare all relevant files. The reviewer receives an independent snapshot and background and returns findings in the required form. The reviewer has no tools or spawning permission. Reviewer calls and tokens count against both the cumulative reviewer allowances and the mission allowances, including reviews of changed snapshots. " (:code (:class "verbatim") ":run-limit") " bounds the number of distinct snapshots reviewed.")

(:p nil "Use " (:code (:class "verbatim") "mission-review.trigger") " with " (:code (:class "verbatim") "id") " to review a checkpoint and " (:code (:class "verbatim") "mission-review.inspect") " to read its durable findings, decisions and usage. Unchanged snapshots reuse completed, failed or interrupted runs. Resolve or reject each finding through " (:code (:class "verbatim") "mission-review.decide") " with " (:code (:class "verbatim") "id") ", " (:code (:class "verbatim") "finding") ", " (:code (:class "verbatim") "decision") " (" (:code (:class "verbatim") "resolve") " or " (:code (:class "verbatim") "reject") ") and an evidence-bearing " (:code (:class "verbatim") "reason") ". Only the primary agent or local user may configure, trigger and adjudicate reviews.")

(:p nil "Final verification runs configured " (:code (:class "verbatim") "final-acceptance") " checkpoints. Pending findings and failed or interrupted reviews block acceptance. For " (:code (:class "verbatim") "before-integration") " and " (:code (:class "verbatim") "after-edit-set") " checkpoints, trigger the named review explicitly at the chosen boundary. Reviewer findings are advisory; mission gates and user acceptance supply harness evidence.")

(:h2 (:id "scheduled-mission-continuations") "Scheduled mission continuations")

(:p nil "Attach explicit wakeups to the current mission with " (:code (:class "verbatim") "mission-schedule.add") ". Supply an immutable " (:code (:class "verbatim") "id") ", continuation " (:code (:class "verbatim") "content") ", and one time policy. " (:code (:class "verbatim") "at") " is an absolute Common Lisp universal time. " (:code (:class "verbatim") "interval") " is a positive number of seconds. " (:code (:class "verbatim") "event") " names an external event instead. For example:")

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

(:p nil "For recurring wakeups, choose " (:code (:class "verbatim") "missed-policy") " " (:code (:class "verbatim") "latest") " (the default), " (:code (:class "verbatim") "all") ", or " (:code (:class "verbatim") "skip") ". These select the newest missed occurrence, every missed occurrence, or only an occurrence due at exactly the current time. Use " (:code (:class "verbatim") "mission-schedule.event") " with an event name and stable external event " (:code (:class "verbatim") "id") "; repeated delivery of that ID is deduplicated. The local daemon listener hosts time wakeups. Due work is persisted in the ordinary primary command queue as " (:code (:class "verbatim") "(mission-wakeup ticket)") ", where " (:code (:class "verbatim") "ticket") " is structured data. The command runs as a mission continuation under the existing turn, token, and wall-clock budgets.")

(:p nil "While a hosted time wakeup of the current mission version is due later or already admitted, automatic goal continuations stop and the mission stays active. The model is not prompted again between occurrences. Within an occurrence, work continues through the turn's own tool calls and through job completions. Event schedules, cancelled schedules, and a finished one-shot wakeup leave ordinary continuations in place. A user message or " (:code (:class "verbatim") "(goal :resume)") " still runs its own turn.")

(:p nil "Only the primary agent may use the " (:code (:class "verbatim") "mission-schedule") " tools. Each wakeup keeps its exact mission identity and version. Both are checked at admission and execution.")

(:p nil "While the mission is paused or blocked, the missed policy skips due occurrences without running them. The interval advances. After a resume, the next due occurrence arrives without recreating the schedule. Skipped occurrences are not replayed, including one-shot wakeups and deduplicated events. With the default " (:code (:class "verbatim") ":block") " policy, unknown usage prevents mission resume. " (:code (:class "verbatim") ":record") " does not prevent an independent pause or blocker from resuming.")

(:p nil "The schedule is cancelled when the mission is replaced, its version changes, or it reaches a terminal state (verified, exhausted, cancelled, failed or legacy complete). Skips and automatic cancellations produce persisted user notices. Use " (:code (:class "verbatim") "mission-schedule.inspect") " to read schedules, occurrence IDs, claim tokens and outcomes: skipped occurrences have " (:code (:class "verbatim") "state") " " (:code (:class "verbatim") "cancelled") " with " (:code (:class "verbatim") "result") " " (:code (:class "verbatim") "(:skipped <mission-status>)") "; obsolete mission work has " (:code (:class "verbatim") "result") " " (:code (:class "verbatim") ":stale-mission") " and a cancelled schedule. Use " (:code (:class "verbatim") "mission-schedule.cancel") " with the schedule " (:code (:class "verbatim") "id") " to cancel future and pending work.")

(:p nil "Interrupted admissions and executions restore as uncertain outcomes. Inspect the external effects before calling " (:code (:class "verbatim") "mission-schedule.resolve") " with the readable " (:code (:class "verbatim") "occurrence") " ID, current " (:code (:class "verbatim") "token") " and " (:code (:class "verbatim") "action") " " (:code (:class "verbatim") "completed") ", " (:code (:class "verbatim") "failed") " or " (:code (:class "verbatim") "retry") ". Retry is an explicit decision and is refused while the occurrence is executing. Cancellation retains claim and duplicate history.")
