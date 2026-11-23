(:h1 (:id "first-session") "First session")

(:ol nil
  "
"
  (:li nil (:strong nil "Connect a model provider.") " To use ChatGPT, run " (:code (:class "verbatim") "autolith auth chatgpt") " and follow the prompts. If you use " (:code (:class "verbatim") "nix run") ", run " (:code (:class "verbatim") "nix run github:lambda-symbolics/autolith -- auth chatgpt") " instead. To use a local model, see " (:a (:href "https://lambda-symbolics.com/autolith/docs/configure-autolith#run-a-local-model") "Set up local inference") ".")
  "
"
  (:li nil (:strong nil "Open a channel.") " Run " (:code (:class "verbatim") "autolith") " or " (:code (:class "verbatim") "nix run github:lambda-symbolics/autolith") " in the directory where you want to work. Select " (:code (:class "verbatim") "inbox") " or another channel in the sidebar. Use " (:code (:class "verbatim") "autolith open") " to reopen the most recent top-level channel in the workspace, or " (:code (:class "verbatim") "autolith open ID") " to open a specific channel.")
  "
"
  (:li nil (:strong nil "Send your first request.") " Try " (:em nil "List the files in this workspace and tell me where to start.") " To see commands, enter " (:code (:class "verbatim") "(help)") " in the same prompt.")
  "
")

(:p nil "Write requests in plain text and enter Lisp commands as parenthesized forms. For example, you can inspect the workspace directly:")

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
    (:div (:class "sourceCode" :id "cb5" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb5-1") (:a (:href "#cb5-1" :aria-hidden "true" :tabindex "-1")) "(resource." (:span (:class "kw") "read") " :uri " (:span (:class "st") "\"workspace:.\"") ")"))))
    "
")
  "
")

(:ul nil
  "
"
  (:li nil "Type an opening parenthesis, bracket, or brace to insert a pair. Type the closing delimiter to move past it, or press Backspace inside an empty pair to delete both delimiters.")
  "
"
  (:li nil "Press Tab to complete a command, option, path, or " (:code (:class "verbatim") "@") " mention. If you complete a mention, press Tab again to cycle through candidates. Use Shift-Tab to cycle backward.")
  "
"
  (:li nil "If there is nothing to complete, Tab submits the prompt or queues it during a turn. Finish an open Lisp form before submitting it.")
  "
")

(:h2 (:id "onboarding") "Onboarding")

(:ol nil
  "
"
  (:li nil "Open a channel. At the boot screen, press Space or Enter to start the tour. To go straight to the prompt, press Esc or start typing. Typed and pasted text is kept in the prompt.")
  "
"
  (:li nil "Try the exercises on the prompt, " (:code (:class "verbatim") "(help)") ", background Lisp, and " (:code (:class "verbatim") "(settings)") ". Edit the exercise input and press Enter to submit it.")
  "
")

(:ul nil
  "
"
  (:li nil "Use Page Up and Page Down to scroll.")
  "
"
  (:li nil "Press Shift-Tab to go back or Tab to skip one slide, including an exercise.")
  "
"
  (:li nil "Press Esc to skip the tour. Press Ctrl-C to interrupt it without marking unfinished lessons as skipped.")
  "
")

(:p nil "On later launches, you see only new or revised lessons. Enter " (:code (:class "verbatim") "(onboard)") " to replay the full tour. To disable the automatic tour, enter " (:code (:class "verbatim") "(settings :onboarding-p nil)") " or set " (:code (:class "verbatim") "AUTOLITH_ONBOARDING") " to " (:code (:class "verbatim") "off") ". If you disable the boot screen, you skip the opening animation.")

(:h2 (:id "boot-screen") "Boot screen")

(:ul nil
  "
"
  (:li nil "To skip " (:em nil "the wait") ", use " (:code (:class "verbatim") "(setf (config :boot-screen-linger-p) nil)") " or set " (:code (:class "verbatim") "AUTOLITH_BOOT_LINGER") " to " (:code (:class "verbatim") "off") " for one launch.")
  "
"
  (:li nil "To change the direct-session animation from 3.5 seconds, set " (:code (:class "verbatim") ":boot-screen-seconds") " or " (:code (:class "verbatim") "AUTOLITH_BOOT_DURATION") ". A hosted channel shows actual progress and does not replay the animation.")
  "
"
  (:li nil "To skip " (:em nil "the boot screen") ", use " (:code (:class "verbatim") "(setf (config :boot-screen-p) nil)") " or set " (:code (:class "verbatim") "AUTOLITH_BOOT_SCREEN") " to " (:code (:class "verbatim") "off") ". See " (:code (:class "verbatim") "(settings)") " for these options.")
  "
")
