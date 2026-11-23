(:h1 (:id "editor-sessions-over-acp") "Editor sessions over ACP")

(:p nil "To open an ACP editor session:")

(:ol nil
  "
"
  (:li nil (:p nil "Authenticate the selected provider with " (:code (:class "verbatim") "autolith auth") "."))
  "
"
  (:li nil (:p nil "Configure your ACP-compatible editor to launch:") "
" (:div (:class "window code-window")
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
        (:div (:class "sourceCode" :id "cb55" :data-org-language "sh")
          (:pre (:class "sourceCode bash") (:code (:class "sourceCode bash") (:span (:id "cb55-1") (:a (:href "#cb55-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " acp"))))
        "
")
      "
"))
  "
"
  (:li nil (:p nil "Open a session in the editor in the directory where you want to work."))
  "
")

(:p nil "To resume the conversation, reopen the same session ID in the editor or use "
 (:code nil "autolith open ID") " in a terminal.")

(:h2 (:id "approvals-and-session-control") "Manage the editor session")

(:ul nil
 (:li nil (:strong nil "Approvals.")
  " Answer prompts in the editor or terminal. To change the default behavior, choose a permission mode in the editor or launch ACP with "
  (:code nil "--permissions auto|sandbox|full") ".")
 (:li nil (:strong nil "MCP servers.")
  " Supply servers before opening a new session. To change the list of servers supplied by the editor, open a new session.")
 (:li nil (:strong nil "Closing.")
  " Cancel the prompt to stop the current turn. Close the session to disconnect the editor."))

(:h2 (:id "remote-clients") "Remote clients")

(:ul nil (:li nil "Use " (:code nil "autolith acp --http") " for an HTTP or WebSocket client.")
 (:li nil "Use " (:code nil "autolith acp --websocket") " for a WebSocket-only listener."))

(:p nil "Both listen on " (:code (:class "verbatim") "127.0.0.1:8737") " by default. Supply a port or a host and port to change the listener:")

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
    (:div (:class "sourceCode" :id "cb56" :data-org-language "sh")
      (:pre (:class "sourceCode bash") (:code (:class "sourceCode bash") (:span (:id "cb56-1") (:a (:href "#cb56-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " acp " (:span (:class "at") "--websocket") " 9000") "
" (:span (:id "cb56-2") (:a (:href "#cb56-2" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " acp " (:span (:class "at") "--http") " 0.0.0.0:8737 " (:span (:class "at") "--token") " " (:span (:class "st") "\"") (:span (:class "va") "$ACP_TOKEN") (:span (:class "st") "\"")) "
" (:span (:id "cb56-3") (:a (:href "#cb56-3" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " acp " (:span (:class "at") "--http") " " (:span (:class "pp") "[") (:span (:class "ss") "::1") (:span (:class "pp") "]") ":8737"))))
    "
")
  "
")

(:p nil "Copy the endpoint URL from the terminal into your client. Press Ctrl-C to stop the server.")

(:p nil "For remote access, put a TLS reverse proxy in front of the listener and require a token.")

(:p nil "Use " (:code nil "Authorization: Bearer TOKEN")
 " if the client supports headers. Otherwise, add " (:code nil "?token=TOKEN") " to the URL.")
