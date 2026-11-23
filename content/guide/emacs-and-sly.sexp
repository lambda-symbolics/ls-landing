(:h1 (:id "emacs-and-sly") "Emacs and sly")

(:p nil "Use " (:code (:class "verbatim") "emacs/autolith.el") " from the source tree to edit code, work in a sly REPL, and talk to Autolith in one Emacs frame. The REPL connects to the same Lisp image as Autolith. The REPL spans the bottom quarter of the frame. Above it, code is on the left and the agent-shell conversation is in the right third.")

(:ol nil
  "
"
  (:li nil (:p nil "Install sly and agent-shell."))
  "
"
  (:li nil (:p nil "Load the integration file:") "
" (:div (:class "window code-window")
      "
"
      (:div (:class "window-titlebar")
        "
Emacs Lisp
")
      "
"
      (:div (:class "window-body")
        "
"
        (:div (:class "sourceCode" :id "cb57" :data-org-language "emacs-lisp")
          (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb57-1") (:a (:href "#cb57-1" :aria-hidden "true" :tabindex "-1")) "(" (:span (:class "kw") "load") " " (:span (:class "st") "\"/path/to/autolith/emacs/autolith.el\"") ")"))))
        "
")
      "
"))
  "
"
  (:li nil (:p nil "In the buffer you want to edit, run " (:code (:class "verbatim") "M-x autolith-ide") ". The command starts the Emacs server if needed, launches the agent, and connects sly."))
  "
")

(:p nil "Optional Sly contribs need their Lisp dependencies in Autolith's image. For " (:code (:class "verbatim") "sly-stepper") ", install " (:code (:class "verbatim") "agnostic-lizard") " in a persistent ASDF source registry visible to the Autolith process before Slynk starts.")

(:p nil (:code (:class "verbatim") "autolith-ide") " starts the Emacs server if needed and launches " (:code (:class "verbatim") "autolith acp") " through agent-shell with three environment variables:")

(:ul nil
  "
"
  (:li nil "Set " (:code nil "AUTOLITH_SLYNK_DIRECTORY") " to the " (:code nil "slynk/") " directory from your sly installation.")
  "
"
  (:li nil (:code (:class "verbatim") "AUTOLITH_SLYNK_PORT_FILE") " receives the loopback port once Slynk listens, or " (:code (:class "verbatim") "error: REASON") " when it cannot start. " (:code (:class "verbatim") "autolith-ide") " waits for it, up to " (:code (:class "verbatim") "autolith-slynk-timeout") " seconds, and connects sly.")
  "
"
  (:li nil "Set " (:code nil "AUTOLITH_EMACS_SERVER") " to the server socket for the Emacs instance you want Autolith to access.")
  "
")

(:p nil (:code (:class "verbatim") "M-x autolith-agent-shell") " starts only the conversation, with Emacs access and without Slynk. The same variables, or the " (:code (:class "verbatim") ":slynk-directory") ", " (:code (:class "verbatim") ":slynk-port-file") " and " (:code (:class "verbatim") ":emacs-server-socket") " settings, work outside Emacs. In the terminal, " (:code (:class "verbatim") "(slynk)") " starts Slynk and shows the port for " (:code (:class "verbatim") "M-x sly-connect") ", and " (:code (:class "verbatim") "(slynk :stop)") " closes it.")

(:p nil "If you enable Emacs access, you can ask Autolith to review the selected region or edit an open buffer, including unsaved text. Review the edits in Emacs and save or undo them there. Access outside the workspace and source roots requires approval.")

(:p nil "Slynk listens on " (:code (:class "verbatim") "127.0.0.1") " only. Like ordinary sly, it has no authentication beyond the optional " (:code (:class "verbatim") "~/.sly-secret") ". Anyone who can reach loopback on this machine can evaluate in the image. Your code shares the agent's heap: a fatal error or " (:code (:class "verbatim") "(sb-ext:exit)") " ends the session, which recovers like any crash.")

(:p nil "Slynk's debugger and output hooks stay off for Autolith's own threads, so your REPL sees only your evaluations. A checkpoint stops Slynk and closes sly connections, then restarts Slynk on the same port. Reconnect with " (:code (:class "verbatim") "M-x autolith-ide-reconnect") ". A checkpoint waits for in-flight sly evaluations and fails if they exceed the shutdown timeout.")
