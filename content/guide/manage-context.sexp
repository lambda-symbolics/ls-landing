(:h1 (:id "manage-context") "Manage context")

(:h2 (:id "compaction") "Compact a long conversation")

(:p nil
 "Autolith compacts long conversations into a checkpoint and keeps recent turns. The context meter shows the token count. The "
 (:code nil "|") " marks the automatic compaction point.")

(:ul nil
 (:li nil "Run " (:code nil "(compact)")
  " to make a checkpoint now. If a turn is active, Autolith waits until the turn ends.")
 (:li nil "Use " (:code nil "(settings :compaction-threshold-percent)")
  " to inspect the threshold. The default is 80% of the context window.")
 (:li nil "Read the transcript if you need the exact text of earlier messages or tool results."))

(:h2 (:id "context") "Add guidance for a project")

(:p nil "Context rules add instructions to model requests that match conditions you specify. Run "
 (:code nil "(context)") " to see the guidance in use.")

(:h3 (:id "save-a-correction") "Save a correction")

(:ol nil
 (:li nil "Run " (:code nil "(complain \"Your explanations are too long. Give the result first.\")")
  ".")
 (:li nil
  "Review the suggested instruction and the text that triggers it. Edit either one if needed.")
 (:li nil "Save it for the current workspace or for all workspaces."))

(:h3 (:id "write-a-context-rule") "Write a rule in Lisp")

(:p nil "Put this example in " (:code nil "init.lisp")
 " to add a reminder after successful tools run on Common Lisp files under " (:code nil "src/") ":")

(:div (:class "window code-window") "
"
 (:div (:class "window-titlebar") "
Common Lisp
")
 "
"
 (:div (:class "window-body") "
"
  (:div (:class "sourceCode" :id "cb28" :data-org-language "lisp")
   (:pre (:class "sourceCode commonlisp")
    (:code (:class "sourceCode commonlisp")
     (:span (:id "cb28-1") (:a (:href "#cb28-1" :aria-hidden "true" :tabindex "-1"))
      "(register-context-rule")
     "
"
     (:span (:id "cb28-2") (:a (:href "#cb28-2" :aria-hidden "true" :tabindex "-1")) " '(:id "
      (:span (:class "st") "\"lisp-edits\""))
     "
"
     (:span (:id "cb28-3") (:a (:href "#cb28-3" :aria-hidden "true" :tabindex "-1"))
      "   :when (:paths (" (:span (:class "st") "\"src/\"") ") :languages ("
      (:span (:class "st") "\"common-lisp\"") ")")
     "
"
     (:span (:id "cb28-4") (:a (:href "#cb28-4" :aria-hidden "true" :tabindex "-1"))
      "          :events (" (:span (:class "st") "\"tool-success\"") "))")
     "
"
     (:span (:id "cb28-5") (:a (:href "#cb28-5" :aria-hidden "true" :tabindex "-1"))
      "   :instruction "
      (:span (:class "st") "\"Check the changed declarations before committing.\""))
     "
"
     (:span (:id "cb28-6") (:a (:href "#cb28-6" :aria-hidden "true" :tabindex "-1")) "   :priority "
      (:span (:class "dv") "30") " :lifetime :while-relevant))"))))
  "
")
 "
")

(:p nil "Add an absolute " (:code nil ":workspace")
 " directory to restrict the rule to one project. Use " (:code nil "context-status")
 " to check whether the rule was used and " (:code nil "unregister-context-rule")
 " with the rule ID to remove it.")

(:h2 (:id "output-limits-and-admission") "Set token limits")

(:p nil "Inspect the effective limits with " (:code nil "(status)") ". Use " (:code nil "(settings)")
 " to find settings for the active model.")

(:ul nil
 (:li nil (:strong nil "Context window.") " Set " (:code nil "AUTOLITH_CONTEXT_WINDOW")
  " for one launch if you need to override the window.")
 (:li nil (:strong nil "Reply length.") " Set " (:code nil "(settings :max-output-tokens N)")
  " to cap the tokens requested for one reply. Use " (:code nil "nil") " to clear the override."))
