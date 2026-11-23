(:h1 (:id "customise-autolith") "Customise commands, skills and Lisp")

(:h2 (:id "commands") "Write a command")

(:p nil "Define commands in " (:code nil "init.lisp") " with "
 (:code nil "define-application-command") ". This example adds " (:code nil "(my-version)")
 " and accepts an optional label:")

(:div (:class "window code-window") "
"
 (:div (:class "window-titlebar") "
Common Lisp
")
 "
"
 (:div (:class "window-body") "
"
  (:div (:class "sourceCode" :id "cb38" :data-org-language "lisp")
   (:pre (:class "sourceCode commonlisp")
    (:code (:class "sourceCode commonlisp")
     (:span (:id "cb38-1") (:a (:href "#cb38-1" :aria-hidden "true" :tabindex "-1"))
      "(define-application-command my-version-command")
     "
"
     (:span (:id "cb38-2") (:a (:href "#cb38-2" :aria-hidden "true" :tabindex "-1")) "    ("
      (:span (:class "bu") ":name") "              " (:span (:class "st") "\"my-version\""))
     "
"
     (:span (:id "cb38-3") (:a (:href "#cb38-3" :aria-hidden "true" :tabindex "-1"))
      "     :aliases           (" (:span (:class "st") "\"local-version\"") ")")
     "
"
     (:span (:id "cb38-4") (:a (:href "#cb38-4" :aria-hidden "true" :tabindex "-1"))
      "     :argument          " (:span (:class "st") "\"[LABEL]\""))
     "
"
     (:span (:id "cb38-5") (:a (:href "#cb38-5" :aria-hidden "true" :tabindex "-1"))
      "     :description       "
      (:span (:class "st") "\"show a labeled local integration version\""))
     "
"
     (:span (:id "cb38-6") (:a (:href "#cb38-6" :aria-hidden "true" :tabindex "-1"))
      "     :tip               "
      (:span (:class "st") "\"shows the version supplied by init.lisp.\""))
     "
"
     (:span (:id "cb38-7") (:a (:href "#cb38-7" :aria-hidden "true" :tabindex "-1"))
      "     :busy-behavior     :execute")
     "
"
     (:span (:id "cb38-8") (:a (:href "#cb38-8" :aria-hidden "true" :tabindex "-1"))
      "     :terminal-behavior :shared")
     "
"
     (:span (:id "cb38-9") (:a (:href "#cb38-9" :aria-hidden "true" :tabindex "-1"))
      "     :callable          " (:span (:class "kw") "t") ")")
     "
"
     (:span (:id "cb38-10") (:a (:href "#cb38-10" :aria-hidden "true" :tabindex "-1"))
      "    (application " (:span (:class "op") "&optional") " (label "
      (:span (:class "st") "\"integration\"") "))")
     "
"
     (:span (:id "cb38-11") (:a (:href "#cb38-11" :aria-hidden "true" :tabindex "-1"))
      "  (application-present application (" (:span (:class "kw") "format") " "
      (:span (:class "kw") "nil") " " (:span (:class "st") "\"~A 3\"") " label))")
     "
"
     (:span (:id "cb38-12") (:a (:href "#cb38-12" :aria-hidden "true" :tabindex "-1"))
      "  :continue)"))))
  "
")
 "
")

(:p nil "After restarting, run " (:code nil "(help 'my-version)")
 " to check the help for the command.")

(:h2 (:id "executable-skills") "Load a skill")

(:p nil "Ask Autolith to load a skill by name, or use " (:code nil "skill.load")
 " with the exact name. Read " (:code nil "skill:NAME") " with " (:code nil "resource.read")
 " to see the catalog entry.")

(:h2 (:id "live-definitions") "Change a live definition")

(:ol nil
 (:li nil "Use " (:code nil "self.define")
  " to add or replace a definition in the running image. Qualify the symbol if it belongs to another package.")
 (:li nil "Test the change in the active image and review it with " (:code nil "self.diff") ".")
 (:li nil "Save the change with " (:code nil "self.commit") " or undo it with "
  (:code nil "self.discard") "."))

(:p nil "If an update skips an override because the tracked definition changed, run "
 (:code nil "(fix-skipped-definitions)") " to review and rebuild the overrides you still need. See "
 (:a (:href "/autolith/docs/generations-and-recovery") "Generations and recovery")
 " for restore commands.")

(:h2 (:id "local-text-redaction") "Redact text locally")

(:p nil "Use " (:code nil "(redact text)") " at the Lisp prompt or " (:code nil "autolith:redact")
 " in a worker. Check the second return value for " (:code nil ":ok")
 ". Review the redacted text before sharing it.")

(:h2 (:id "active-image-management-endpoint") "Connect to the running Lisp image")

(:ol nil
 (:li nil "Put a nonempty token in "
  (:code nil "${XDG_CONFIG_HOME:-~/.config}/autolith/management-repl.token")
  ". Own the file and set the permissions to " (:code nil "0600") ".")
 (:li nil "Connect from a trusted local Lisp client with " (:code nil "eval-connect") " from "
  (:code nil "image-daemon") ". On Unix, the default socket is "
  (:code nil "${XDG_STATE_HOME:-~/.local/state}/autolith/management/repl.sock") ". On Windows, use "
  (:code nil "127.0.0.1:4141") ".")
 (:li nil "Use " (:code nil "eval-call")
  " to evaluate a form in the running image. Review the result before sharing it because it may contain secrets."))
