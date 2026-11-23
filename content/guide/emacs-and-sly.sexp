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
  (:li nil (:code (:class "verbatim") "AUTOLITH_SLYNK_DIRECTORY") " is your sly's own " (:code (:class "verbatim") "slynk/") " directory, so the server speaks exactly your client's protocol. Autolith loads that " (:code (:class "verbatim") "slynk.asd") " by path and compiles it into the ASDF cache on first use.")
  "
"
  (:li nil (:code (:class "verbatim") "AUTOLITH_SLYNK_PORT_FILE") " receives the loopback port once Slynk listens, or " (:code (:class "verbatim") "error: REASON") " when it cannot start. " (:code (:class "verbatim") "autolith-ide") " waits for it, up to " (:code (:class "verbatim") "autolith-slynk-timeout") " seconds, and connects sly.")
  "
"
  (:li nil (:code (:class "verbatim") "AUTOLITH_EMACS_SERVER") " is this Emacs's server socket and enables the " (:code (:class "verbatim") "emacs:") " resources and " (:code (:class "verbatim") "emacs.*") " tools.")
  "
")

(:p nil (:code (:class "verbatim") "M-x autolith-agent-shell") " starts only the conversation, with Emacs access and without Slynk. The same variables, or the " (:code (:class "verbatim") ":slynk-directory") ", " (:code (:class "verbatim") ":slynk-port-file") " and " (:code (:class "verbatim") ":emacs-server-socket") " settings, work outside Emacs. In the terminal, " (:code (:class "verbatim") "(slynk)") " starts Slynk and shows the port for " (:code (:class "verbatim") "M-x sly-connect") ", and " (:code (:class "verbatim") "(slynk :stop)") " closes it.")

(:p nil "The agent reaches your definitions with " (:code (:class "verbatim") "lisp.describe") ", " (:code (:class "verbatim") "lisp.source") " and " (:code (:class "verbatim") "lisp.apropos") " using target " (:code (:class "verbatim") "self") ", or with " (:code (:class "verbatim") "self.eval") ". While Slynk serves, a context note tells it so. Your Emacs appears to the agent only while the configured server socket exists:")

(:ul nil
  "
"
  (:li nil (:code (:class "verbatim") "emacs:current") ", read with " (:code (:class "verbatim") "resource.read") ", lists authorized visible windows with point, the active region and open file buffers, each by its " (:code (:class "verbatim") "emacs:buffer/NAME") " URI. Outside-root files and non-file buffers require full-access approval; denied buffers are omitted from this snapshot.")
  "
"
  (:li nil (:code (:class "verbatim") "emacs:buffer/NAME") " is a live buffer's text, unsaved edits included, with the buffer name percent-encoded. " (:code (:class "verbatim") "resource.edit") " applies line operations to the buffer itself: the change stays unsaved and undoable, and is refused as stale if you have edited the buffer since the agent read it. A buffer visiting a file outside the workspace and source roots asks the same permission as that path.")
  "
"
  (:li nil (:code (:class "verbatim") "emacs.visit") " shows a file position in a file window of the selected frame.")
  "
"
  (:li nil (:code (:class "verbatim") "emacs.eval") " evaluates Emacs Lisp. It asks command authorization for " (:code (:class "verbatim") "emacs.eval -- FORM") " and runs only with full access.")
  "
")

(:p nil "Slynk listens on " (:code (:class "verbatim") "127.0.0.1") " only. Like ordinary sly, it has no authentication beyond the optional " (:code (:class "verbatim") "~/.sly-secret") ". Anyone who can reach loopback on this machine can evaluate in the image. Your code shares the agent's heap: a fatal error or " (:code (:class "verbatim") "(sb-ext:exit)") " ends the session, which recovers like any crash.")

(:p nil "Slynk's debugger and output hooks stay off for Autolith's own threads, so your REPL sees only your evaluations. A checkpoint stops Slynk and closes sly connections, then restarts Slynk on the same port. Reconnect with " (:code (:class "verbatim") "M-x autolith-ide-reconnect") ". A checkpoint waits for in-flight sly evaluations and fails if they exceed the shutdown timeout.")
