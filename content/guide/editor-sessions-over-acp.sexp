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
  (:li nil (:p nil "Open a session in the editor. ACP uses UTF-8 JSON-RPC on stdin and stdout. Diagnostics go to stderr."))
  "
")

(:p nil "Autolith starts the world server if needed. A new session opens a channel in the absolute working directory supplied by the editor. The session ID is the conversation ID. Load that ID to replay messages, visible reasoning, tool calls, and results, then follow the channel. You can view the same channel in a terminal. ACP accepts text prompts, resource links, and embedded text resources. File and process operations use the native Autolith tools.")

(:p nil "The world server does not run in pristine mode. For a pristine rescue session, use " (:code (:class "verbatim") "autolith resume --pristine") " in a terminal.")

(:ul nil
  "
"
  (:li nil (:strong nil "Approvals.") " In " (:code (:class "verbatim") "ask") " mode, the editor receives the channel's choices. The first answer from the editor or terminal counts. Select " (:code (:class "verbatim") "auto") ", " (:code (:class "verbatim") "sandboxed") ", or " (:code (:class "verbatim") "full-access") " in the editor, or use " (:code (:class "verbatim") "--permissions auto|sandbox|full") " at launch. Changing the mode in the editor changes it for the channel.")
  "
"
  (:li nil (:strong nil "MCP.") " You can supply stdio and HTTP MCP servers when the server starts a channel for the session. An existing channel refuses new servers and returns the reason. Literal environment values and headers are kept temporarily and redacted from server output.")
  "
"
  (:li nil (:strong nil "Closing.") " Cancel a prompt to stop the current turn. A prompt returns after the turn ends. Closing the session stops following the channel. Autolith closes a channel it started for that session if nothing else follows it. " (:code (:class "verbatim") "Ctrl-C") " leaves all channels and exits the ACP process with status 130.")
  "
")

(:h2 (:id "remote-clients") "Remote clients")

(:ul nil
  "
"
  (:li nil "Use " (:code (:class "verbatim") "autolith acp --http") " for Streamable HTTP (HTTP/1.1 or cleartext HTTP/2) and WebSocket at " (:code (:class "verbatim") "/acp") ".")
  "
"
  (:li nil "Use " (:code (:class "verbatim") "autolith acp --websocket") " for WebSocket alone.")
  "
")

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

(:p nil "Autolith prints the endpoint URL on stderr and serves until Ctrl-C. Each client gets its own sessions, each a channel of the world server.")

(:p nil (:strong nil "For remote access") ", put a TLS reverse proxy in front of the listener and require a token. ACP does not encrypt the traffic itself. A non-loopback bind can make the agent reachable from other machines. Other local users can read a token passed on the command line.")

(:p nil "With " (:code (:class "verbatim") "--token") ", send " (:code (:class "verbatim") "Authorization: Bearer TOKEN") " or add " (:code (:class "verbatim") "?token=TOKEN") " to the URL. Autolith rejects requests that carry an " (:code (:class "verbatim") "Origin") " header.")

(:h2 (:id "typed-client-extensions") "Typed client extensions")

(:p nil "Request " (:code (:class "verbatim") "_autolith/capabilities") " to discover installed methods and schema version. Include " (:code (:class "verbatim") "sessionId") " in every other extension request. Responses contain " (:code (:class "verbatim") "outcome") " (" (:code (:class "verbatim") "ok") ", " (:code (:class "verbatim") "condition") ", " (:code (:class "verbatim") "busy") ", " (:code (:class "verbatim") "unsupported") ", or " (:code (:class "verbatim") "cancelled") "), with " (:code (:class "verbatim") "value") " on success and a bounded " (:code (:class "verbatim") "report") " on failure. Unknown measurements are JSON null.")

(:div (:class "table-scroll")
  "
"
  (:table nil
    "
"
    (:thead nil
      "
"
      (:tr nil
        "
"
        (:th nil "Method suffix")
        "
"
        (:th nil "Value or action")
        "
")
      "
")
    "
"
    (:tbody nil
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "state"))
        "
"
        (:td nil "Session, turn, model, permission, usage, plan and health snapshot")
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "settings") ", " (:code (:class "verbatim") "models") ", " (:code (:class "verbatim") "operations"))
        "
"
        (:td nil "Typed catalog " (:code (:class "verbatim") "items"))
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "set-setting"))
        "
"
        (:td nil "Set " (:code (:class "verbatim") "name") " to " (:code (:class "verbatim") "value") "; return the updated setting row")
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "invoke"))
        "
"
        (:td nil "Invoke " (:code (:class "verbatim") "operation") " with JSON " (:code (:class "verbatim") "arguments") "; return presented " (:code (:class "verbatim") "text"))
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "steer") ", " (:code (:class "verbatim") "queue"))
        "
"
        (:td nil "Durably admit primary " (:code (:class "verbatim") "text") "; return " (:code (:class "verbatim") "accepted") " and " (:code (:class "verbatim") "delivery"))
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "conversations"))
        "
"
        (:td nil "Page durable conversations using " (:code (:class "verbatim") "limit") " and " (:code (:class "verbatim") "cursor") "; optionally filter " (:code (:class "verbatim") "cwd"))
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "jobs") ", " (:code (:class "verbatim") "job"))
        "
"
        (:td nil "Page owned jobs or inspect one " (:code (:class "verbatim") "jobId"))
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "job-transcript"))
        "
"
        (:td nil "Read " (:code (:class "verbatim") "jobId") " with " (:code (:class "verbatim") "offset") ", " (:code (:class "verbatim") "limit") " and " (:code (:class "verbatim") "output") " (" (:code (:class "verbatim") "text") " or " (:code (:class "verbatim") "structured") ")")
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "job-send") ", " (:code (:class "verbatim") "job-cancel"))
        "
"
        (:td nil "Send " (:code (:class "verbatim") "text") " to or cancel an owned " (:code (:class "verbatim") "jobId"))
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "resource"))
        "
"
        (:td nil "Read bounded " (:code (:class "verbatim") "workspace:") " lines or " (:code (:class "verbatim") "shell-log:") " bytes from " (:code (:class "verbatim") "uri"))
        "
")
      "
")
    "
")
  "
")

(:p nil "Prefix these suffixes with " (:code (:class "verbatim") "_autolith/") ". Catalog operations expose admission and availability; tools use their native decoders and ACP approval callbacks. Terminal-only operations return an explicit unsupported outcome. Workspace resource windows use " (:code (:class "verbatim") "startLine") " and " (:code (:class "verbatim") "lineCount") " and include the observed revision. Shell-log windows use " (:code (:class "verbatim") "byteOffset") " and " (:code (:class "verbatim") "byteCount") " with the exact retained reference.")

(:p nil "For a command, send " (:code (:class "verbatim") "arguments") " as a JSON array in Lisp argument order. For example, " (:code (:class "verbatim") "(settings :turn-timestamps-p t)") " takes " (:code (:class "verbatim") "[{\"keyword\":\"turn-timestamps-p\"}, true]") ". A keyword is an object with exactly one " (:code (:class "verbatim") "keyword") " member whose value is a nonempty string. For a tool, send " (:code (:class "verbatim") "arguments") " as an object keyed by parameter name. Operations with " (:code (:class "verbatim") "terminalWithoutArguments") " require an argument to avoid a terminal picker. During an active turn, boundary-applied commands return " (:code (:class "verbatim") "delivery: \"scheduled\"") " and present their results as ACP updates.")

(:p nil (:code (:class "verbatim") "steer") " delivers text at the next safe boundary, including submissions made while an approval is pending. Late steering is promoted ahead of ordinary queued follow-ups. " (:code (:class "verbatim") "queue") " appends a follow-up for the next available primary turn. Both accept up to 262144 characters and return " (:code (:class "verbatim") "delivery: \"steering\"") " or " (:code (:class "verbatim") "\"queued\"") ". Display accepted input separately until its durable " (:code (:class "verbatim") "user_message_chunk") " arrives. Cancellation pauses pending input; a new submission resumes it. Accepted input survives session close and reload. ACP has no per-item withdrawal operation.")

(:p nil "For structured child transcripts, " (:code (:class "verbatim") "value.updates") " contains ordinary ACP SessionUpdate bodies, with messages, reasoning, tool calls and result content. Offsets count updates from zero; the default limit is 100 and the maximum is 200. The typed response envelope is bounded to 262144 UTF-8 bytes. A single update over that bound returns a condition instead of advancing the cursor. " (:code (:class "verbatim") "nextOffset") " is JSON null when " (:code (:class "verbatim") "complete") " is true, meaning the current snapshot is exhausted. For a running child, poll again from " (:code (:class "verbatim") "total") " to read later updates. Text output uses character offsets and retains its existing numeric end cursor.")

(:p nil "Treat " (:code (:class "verbatim") "_autolith/event") " state and catalog notifications as invalidation hints. Refetch the affected snapshot after a sequence gap. Events with kind " (:code (:class "verbatim") "turn") " are ordered lifecycle boundaries: " (:code (:class "verbatim") "data") " contains " (:code (:class "verbatim") "state") " (" (:code (:class "verbatim") "running") " or " (:code (:class "verbatim") "idle") "), an integer " (:code (:class "verbatim") "epoch") ", " (:code (:class "verbatim") "source") " (" (:code (:class "verbatim") "prompt") ", " (:code (:class "verbatim") "queue") ", " (:code (:class "verbatim") "completion") ", or " (:code (:class "verbatim") "invoke") "), and a terminal " (:code (:class "verbatim") "outcome") " (" (:code (:class "verbatim") "end-turn") ", " (:code (:class "verbatim") "cancelled") ", or " (:code (:class "verbatim") "condition") "; null while running). Match the epoch when handling approvals, cancellation and transcript boundaries.")

(:p nil "Automatic job continuations stream through ordinary ACP updates. Cancellation or an inference failure pauses continuation; submit an explicit prompt to resume.")
