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

(:h2 (:id "context") "Save a recurring correction")

(:p nil "If you find yourself giving Autolith the same correction, save it for later conversations.")

(:ol nil
 (:li nil "Run " (:code nil "(complain \"Your explanations are too long. Give the result first.\")")
  ".")
 (:li nil
  "Review the suggested instruction and the text that triggers it. Edit either one if needed.")
 (:li nil "Save it for the current workspace or for all workspaces."))

(:h2 (:id "output-limits-and-admission") "Set token limits")

(:p nil "Inspect the effective limits with " (:code nil "(status)") ". Use " (:code nil "(settings)")
 " to find settings for the active model.")

(:ul nil
 (:li nil (:strong nil "Context window.") " Set " (:code nil "AUTOLITH_CONTEXT_WINDOW")
  " for one launch if you need to override the window.")
 (:li nil (:strong nil "Reply length.") " Set " (:code nil "(settings :max-output-tokens N)")
  " to cap the tokens requested for one reply. Use " (:code nil "nil") " to clear the override."))
