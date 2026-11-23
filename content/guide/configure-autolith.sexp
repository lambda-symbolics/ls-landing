(:h1 (:id "configure-autolith") "Configure Autolith")

(:p nil "Put personal configuration in " (:code (:class "verbatim") "${XDG_CONFIG_HOME:-~/.config}/autolith/init.lisp") ". This file runs as Common Lisp in the " (:code (:class "verbatim") "AUTOLITH") " package with your privileges. Use " (:code (:class "verbatim") "--pristine") " to skip private replay and executable initialization.")

(:p nil "After the tracked code and selected private image have loaded, Autolith loads these files in order:")

(:ol nil
  "
"
  (:li nil "The site " (:code (:class "verbatim") "init.lisp") ", if a site root is configured.")
  "
"
  (:li nil "Trusted " (:code (:class "verbatim") ".autolith/init.lisp") " files, from the outermost directory to the nearest one.")
  "
"
  (:li nil "Your personal " (:code (:class "verbatim") "init.lisp") ".")
  "
")

(:p nil "This order also applies to " (:code (:class "verbatim") "autolith models") " and " (:code (:class "verbatim") "autolith auth") ". Your personal file reloads if you reconnect to a retained generation. Startup or reload reports the pathname if a configuration file cannot be read or evaluated.")

(:p nil "Packagers can set a read-only site root with " (:code (:class "verbatim") "--site-config-root DIRECTORY") " or " (:code (:class "verbatim") "AUTOLITH_SITE_CONFIG_ROOT") ". Use an existing absolute directory. It can contain " (:code (:class "verbatim") "init.lisp") ", " (:code (:class "verbatim") "mcp.sexp") ", " (:code (:class "verbatim") "skills/") " and " (:code (:class "verbatim") "agents/") ". A site " (:code (:class "verbatim") "init.lisp") " runs with the same privileges as personal configuration. Use an explicit site root in place of " (:code (:class "verbatim") "XDG_CONFIG_DIRS") ".")

(:h2 (:id "settings") "Settings")

(:p nil "Use " (:code (:class "verbatim") "(settings)") " to open the settings picker. Select a setting to see the current value, where it came from, and the available choices. In a script, " (:code (:class "verbatim") "(settings)") " prints the settings by area.")

(:p nil "You can use the same command without the picker:")

(:ul nil
  "
"
  (:li nil (:code (:class "verbatim") "(settings :boot-screen-seconds)") " describes the setting.")
  "
"
  (:li nil (:code (:class "verbatim") "(settings :boot-screen-seconds 2)") " sets the value.")
  "
"
  (:li nil "Use " (:code (:class "verbatim") "t") " or " (:code (:class "verbatim") "nil") " for switches. Omit the value if you only want to inspect the setting. An explicit " (:code (:class "verbatim") "nil") " counts as a value.")
  "
")

(:p nil "Settings have four scopes:")

(:ul nil
  "
"
  (:li nil (:strong nil "Durable.") " Your model, reasoning effort, reasoning traces, timestamps and saved permission mode belong to this scope. Changes are saved immediately in " (:code (:class "verbatim") "preferences.sexp") " under the configuration directory.")
  "
"
  (:li nil (:strong nil "Session.") " Settings such as hurry-up mode last until exit.")
  "
"
  (:li nil (:strong nil "Process.") " Startup sets the configuration roots and management endpoint.")
  "
"
  (:li nil (:strong nil "Derived.") " The provider endpoint and context window depend on the model. For the context window, Autolith tries the declared value first, then the catalog value, then the default.")
  "
")

(:p nil "For durable settings, the first available source wins:")

(:ol nil
  "
"
  (:li nil "An explicit command-line option.")
  "
"
  (:li nil "The environment variable for the setting.")
  "
"
  (:li nil "The saved value in " (:code (:class "verbatim") "preferences.sexp") ".")
  "
")

(:p nil "If a saved provider or model is unavailable, Autolith uses a registered choice and shows a notice. Register the provider again to recover the saved choice at next startup. Invalid command-line or environment choices produce an error. Use " (:code (:class "verbatim") "--model") " or " (:code (:class "verbatim") "AUTOLITH_MODEL") " to select a model served by the provider.")

(:p nil "In Lisp, read settings with " (:code (:class "verbatim") "(config :model)") " or pass an explicit configuration with " (:code (:class "verbatim") "(config :model configuration)") ". Change the current value with " (:code (:class "verbatim") "(setf (config :reasoning-traces-p) t)") ". Use " (:code (:class "verbatim") "configuration-copy") " to make a separate configuration.")

(:p nil (:strong nil "Upgrading from preferences versions 1 through 7:") " Run Autolith 0.53 once to write version 8 before you upgrade to 0.54 or later.")

(:h2 (:id "language-servers") "Language servers")

(:ol nil
  "
"
  (:li nil "Install a language server that you trust. It runs with your privileges and inherits your environment.")
  "
"
  (:li nil "Create " (:code (:class "verbatim") "lsp.sexp") " in your user configuration directory, beside " (:code (:class "verbatim") "init.lisp") ". Here is a configuration for " (:code (:class "verbatim") "clangd") ":")
  "
")

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
    (:div (:class "sourceCode" :id "cb22" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb22-1") (:a (:href "#cb22-1" :aria-hidden "true" :tabindex "-1")) "(" (:span (:class "bu") ":version") " " (:span (:class "dv") "1")) "
" (:span (:id "cb22-2") (:a (:href "#cb22-2" :aria-hidden "true" :tabindex "-1")) " :servers ((" (:span (:class "bu") ":name") " " (:span (:class "st") "\"clangd\"")) "
" (:span (:id "cb22-3") (:a (:href "#cb22-3" :aria-hidden "true" :tabindex "-1")) "            :command " (:span (:class "st") "\"clangd\"")) "
" (:span (:id "cb22-4") (:a (:href "#cb22-4" :aria-hidden "true" :tabindex "-1")) "            :arguments (" (:span (:class "st") "\"--background-index\"") ")") "
" (:span (:id "cb22-5") (:a (:href "#cb22-5" :aria-hidden "true" :tabindex "-1")) "            :extensions (" (:span (:class "st") "\".c\"") " " (:span (:class "st") "\".h\"") ")") "
" (:span (:id "cb22-6") (:a (:href "#cb22-6" :aria-hidden "true" :tabindex "-1")) "            :language-id " (:span (:class "st") "\"c\"")) "
" (:span (:id "cb22-7") (:a (:href "#cb22-7" :aria-hidden "true" :tabindex "-1")) "            :root-markers (" (:span (:class "st") "\"compile_commands.json\"") " " (:span (:class "st") "\".git\"") ")") "
" (:span (:id "cb22-8") (:a (:href "#cb22-8" :aria-hidden "true" :tabindex "-1")) "            :timeout-seconds " (:span (:class "dv") "30") ")))"))))
    "
")
  "
")

(:p nil "For each server, provide a unique " (:code (:class "verbatim") ":name") ", a " (:code (:class "verbatim") ":command") " on " (:code (:class "verbatim") "PATH") ", a nonempty " (:code (:class "verbatim") ":extensions") " list and a " (:code (:class "verbatim") ":language-id") ". Use literal strings for arguments.")

(:ul nil
  "
"
  (:li nil "Use JSON object strings for " (:code (:class "verbatim") ":initialization-options") " and " (:code (:class "verbatim") ":settings") ".")
  "
"
  (:li nil "Set " (:code (:class "verbatim") ":disabled-p t") " to disable an entry.")
  "
"
  (:li nil "The request timeout defaults to 30 seconds. You can set it to an integer from 1 through 120.")
  "
")

(:p nil "Autolith reads LSP configuration from your user configuration directory.")

(:p nil "Configure at least one enabled server to use the " (:code (:class "verbatim") "lsp") " tools. If the file is malformed, run " (:code (:class "verbatim") "lsp.status") " to inspect the configuration error.")

(:p nil "Ask Autolith to use these tools:")

(:ul nil
  "
"
  (:li nil (:code (:class "verbatim") "lsp.status") ": inspect configuration and running project/server pairs.")
  "
"
  (:li nil (:code (:class "verbatim") "lsp.query") ": request " (:code (:class "verbatim") "definition") ", " (:code (:class "verbatim") "references") ", " (:code (:class "verbatim") "hover") ", " (:code (:class "verbatim") "implementation") ", " (:code (:class "verbatim") "type-definition") ", " (:code (:class "verbatim") "document-symbols") ", or " (:code (:class "verbatim") "workspace-symbols") " for a workspace file. Position queries require one-based " (:code (:class "verbatim") "line") " and " (:code (:class "verbatim") "character") " coordinates, with columns measured in UTF-16 code units. For workspace symbols, supply " (:code (:class "verbatim") "query") "; the file selects the project and server.")
  "
"
  (:li nil (:code (:class "verbatim") "lsp.diagnostics") ": synchronize a file and retrieve diagnostics.")
  "
"
  (:li nil (:code (:class "verbatim") "lsp.restart") ": stop servers and reload the configuration after changing it.")
  "
")

(:p nil "Use " (:code (:class "verbatim") "lsp.semantic") " for revisioned transformations:")

(:ul nil
  "
"
  (:li nil (:code (:class "verbatim") "prepare-rename") ": inspect the symbol at " (:code (:class "verbatim") "path") ", " (:code (:class "verbatim") "line") " and " (:code (:class "verbatim") "character") ".")
  "
"
  (:li nil (:code (:class "verbatim") "rename") ": propose a symbol rename with those coordinates and " (:code (:class "verbatim") "new-name") ".")
  "
"
  (:li nil (:code (:class "verbatim") "code-actions") ": discover choices for a range, using " (:code (:class "verbatim") "line") ", " (:code (:class "verbatim") "character") ", " (:code (:class "verbatim") "end-line") " and " (:code (:class "verbatim") "end-character") ". Optionally filter " (:code (:class "verbatim") "only") " action kinds or supply " (:code (:class "verbatim") "diagnostics") ".")
  "
"
  (:li nil (:code (:class "verbatim") "resolve") ": retrieve a complete action using its returned " (:code (:class "verbatim") "choice") " ID.")
  "
"
  (:li nil (:code (:class "verbatim") "propose") ": retain an action's edit as an applicable proposal using " (:code (:class "verbatim") "choice") ".")
  "
"
  (:li nil (:code (:class "verbatim") "move") ": propose server preparatory edits followed by moving " (:code (:class "verbatim") "path") " to " (:code (:class "verbatim") "new-path") ". Both paths must identify regular files or a missing destination.")
  "
"
  (:li nil (:code (:class "verbatim") "inspect") ": review a retained " (:code (:class "verbatim") "proposal") " ID.")
  "
"
  (:li nil (:code (:class "verbatim") "apply") ": apply a retained " (:code (:class "verbatim") "proposal") ". Obtain explicit approval for annotations with " (:code (:class "verbatim") "needsConfirmation") ", then include their IDs in " (:code (:class "verbatim") "approved-annotations") ". Confirm each synthetic " (:code (:class "verbatim") "lsp.semantic-confirmation") " request through the ordinary command-permission prompt. Without a permission callback, confirmation is denied.")
  "
")

(:p nil "Use local " (:code (:class "verbatim") "file:///") " URIs for regular files. Before you apply a proposal, Autolith checks permissions, file revisions and synchronized versions. Request a new proposal after a conflicting edit or server restart. Server commands are returned as data for separate approval and execution.")

(:p nil "Autolith starts servers on demand. It uses the nearest configured root marker inside the workspace, or the workspace itself if no marker matches. All enabled servers that match the file suffix receive the request. Open files are refreshed from disk first.")

(:p nil (:strong nil "Diagnostics.") " Ranges are zero-based and measured in UTF-16 code units. The " (:code (:class "verbatim") "sources") " field gives the freshness of push and pull results. The diagnostic state means:")

(:ul nil
  "
"
  (:li nil (:code (:class "verbatim") "received") ": The report is versioned.")
  "
"
  (:li nil (:code (:class "verbatim") "unversioned") ": The snapshot of the file could not be confirmed.")
  "
"
  (:li nil (:code (:class "verbatim") "pending") ": No report arrived.")
  "
")

(:p nil "The automatic check after " (:code (:class "verbatim") "resource.edit") " shares a one-second deadline across all matching servers. If it times out, use " (:code (:class "verbatim") "lsp.diagnostics") " to allow two seconds for push reports and the configured timeout for pull requests. Use " (:code (:class "verbatim") "lsp.restart") " to release the servers.")

(:h2 (:id "active-image-management-endpoint") "Active-image management endpoint")

(:p nil "The management REPL is an always-enabled endpoint for evaluating Common Lisp in the running " (:code (:class "verbatim") "AUTOLITH") " image. Use " (:code (:class "verbatim") "eval-connect") " and " (:code (:class "verbatim") "eval-call") " from " (:code (:class "verbatim") "image-daemon") " to connect from Lisp.")

(:p nil "Put a nonempty token in a regular file owned by your user with mode " (:code (:class "verbatim") "0600") ". Connections use HMAC-SHA-256 and a fresh nonce. The token itself is read from the file during authentication and is not sent over the connection.")

(:p nil "The following environment variables configure newly created applications:")

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
        (:th nil "Variable")
        "
"
        (:th nil "Default")
        "
"
        (:th nil "Meaning")
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
        (:td nil (:code (:class "verbatim") "AUTOLITH_MANAGEMENT_REPL_TRANSPORT"))
        "
"
        (:td nil (:code (:class "verbatim") "unix") ", or " (:code (:class "verbatim") "tcp") " on Windows")
        "
"
        (:td nil (:code (:class "verbatim") "unix") " or " (:code (:class "verbatim") "tcp") ".")
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "AUTOLITH_MANAGEMENT_REPL_UNIX_SOCKET"))
        "
"
        (:td nil (:code (:class "verbatim") "${XDG_STATE_HOME:-~/.local/state}/autolith/management/repl.sock"))
        "
"
        (:td nil "Unix socket pathname.")
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "AUTOLITH_MANAGEMENT_REPL_TCP_ADDRESS"))
        "
"
        (:td nil (:code (:class "verbatim") "127.0.0.1"))
        "
"
        (:td nil "IPv4 loopback listener address.")
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "AUTOLITH_MANAGEMENT_REPL_TCP_PORT"))
        "
"
        (:td nil (:code (:class "verbatim") "4141"))
        "
"
        (:td nil "TCP listener port.")
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "AUTOLITH_MANAGEMENT_REPL_TOKEN_FILE"))
        "
"
        (:td nil (:code (:class "verbatim") "${XDG_CONFIG_HOME:-~/.config}/autolith/management-repl.token"))
        "
"
        (:td nil "Mode-0600 token file.")
        "
")
      "
")
    "
")
  "
")

(:p nil "Evaluation and authentication deadlines are 10 seconds. Frames are bounded to 1 MiB, source and output to 256 KiB, and queued evaluations and clients to 64.")

(:p nil (:strong nil "Trust boundary.") " TCP is restricted to IPv4 loopback and uses no TLS. Use trusted local clients. Evaluation results can contain secrets.")

(:p nil "On Unix, Autolith uses a mode-0700 directory and a mode-0600 socket. Startup can replace a stale socket owned by the current user. On Windows, use TCP.")

(:h3 (:id "wire-protocol") "Wire protocol")

(:p nil "Each message is a four-octet unsigned big-endian length followed by exactly that many UTF-8 octets containing one readable S-expression. Length zero, oversized or truncated frames, invalid UTF-8, malformed syntax, and trailing forms are rejected. Readers use standard I/O syntax, a fresh standard readtable, and " (:code (:class "verbatim") "*read-eval*") " " (:code (:class "verbatim") "nil") ".")

(:p nil "The server starts each connection with:")

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
    (:div (:class "sourceCode" :id "cb23" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb23-1") (:a (:href "#cb23-1" :aria-hidden "true" :tabindex "-1")) "(:challenge " (:span (:class "bu") ":version") " " (:span (:class "dv") "1") " :algorithm :hmac-sha-256 :nonce HEX)"))))
    "
")
  "
")

(:p nil (:code (:class "verbatim") "HEX") " encodes 32 random nonce octets as 64 lowercase hexadecimal characters. The client reads its token file, computes " (:code (:class "verbatim") "HMAC-SHA-256(token, nonce)") ", and replies:")

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
    (:div (:class "sourceCode" :id "cb24" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb24-1") (:a (:href "#cb24-1" :aria-hidden "true" :tabindex "-1")) "(:authenticate :proof HEX)"))))
    "
")
  "
")

(:p nil "A valid proof receives " (:code (:class "verbatim") "(:authenticated :version 1)") ". A proof is valid only for that connection's nonce. Authentication failure closes the connection without a reusable credential or detailed oracle response.")

(:p nil "After authentication, send one request at a time:")

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
    (:div (:class "sourceCode" :id "cb25" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb25-1") (:a (:href "#cb25-1" :aria-hidden "true" :tabindex "-1")) "(:evaluate :source " (:span (:class "st") "\"(values (+ 20 22) *package*)\"") ")"))))
    "
")
  "
")

(:p nil "Send one form per request. Autolith evaluates it in the " (:code (:class "verbatim") "AUTOLITH") " package and captures output. A successful response looks like this:")

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
    (:div (:class "sourceCode" :id "cb26" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb26-1") (:a (:href "#cb26-1" :aria-hidden "true" :tabindex "-1")) "(:evaluation-result") "
" (:span (:id "cb26-2") (:a (:href "#cb26-2" :aria-hidden "true" :tabindex "-1")) " :status :ok") "
" (:span (:id "cb26-3") (:a (:href "#cb26-3" :aria-hidden "true" :tabindex "-1")) " :values (" (:span (:class "st") "\"42\"") " " (:span (:class "st") "\"#<PACKAGE ") (:span (:class "sc") "\\\"") (:span (:class "st") "AUTOLITH") (:span (:class "sc") "\\\"") (:span (:class "st") ">\"") ")") "
" (:span (:id "cb26-4") (:a (:href "#cb26-4" :aria-hidden "true" :tabindex "-1")) " :values-truncated-p " (:span (:class "kw") "nil")) "
" (:span (:id "cb26-5") (:a (:href "#cb26-5" :aria-hidden "true" :tabindex "-1")) " " (:span (:class "bu") ":output") " " (:span (:class "st") "\"\"")) "
" (:span (:id "cb26-6") (:a (:href "#cb26-6" :aria-hidden "true" :tabindex "-1")) " :output-truncated-p " (:span (:class "kw") "nil") ")"))))
    "
")
  "
")

(:p nil "The " (:code (:class "verbatim") ":values") " list contains one string per return value. A condition response includes " (:code (:class "verbatim") ":condition-type") " and " (:code (:class "verbatim") ":report") ". A deadline returns " (:code (:class "verbatim") ":status :timeout") ". The connection can accept another request. The deadline is best effort because trusted forms can suppress interrupts.")

(:p nil "Autolith stops the endpoint before a checkpoint and restarts it afterward. If the evaluator cannot stop within two seconds, the checkpoint fails with " (:code (:class "verbatim") "management-repl-error") " and operation " (:code (:class "verbatim") ":quiesce") ".")

(:h2 (:id "context") "Context")

(:p nil "Use " (:strong nil "ephemeral notes") " to add temporary information to provider requests without adding conversation messages. For example, register advice for release requests:")

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
    (:div (:class "sourceCode" :id "cb27" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb27-1") (:a (:href "#cb27-1" :aria-hidden "true" :tabindex "-1")) "(define-context-contributor release-advice (request)") "
" (:span (:id "cb27-2") (:a (:href "#cb27-2" :aria-hidden "true" :tabindex "-1")) "  " (:span (:class "st") "\"Add advice for release requests.\"")) "
" (:span (:id "cb27-3") (:a (:href "#cb27-3" :aria-hidden "true" :tabindex "-1")) "  (" (:span (:class "kw") "when") " (" (:span (:class "kw") "search") " " (:span (:class "st") "\"release\"") " (" (:span (:class "kw") "or") " (request-context-latest-user-text request) " (:span (:class "st") "\"\"") ")") "
" (:span (:id "cb27-4") (:a (:href "#cb27-4" :aria-hidden "true" :tabindex "-1")) "                " (:span (:class "bu") ":test") " " (:span (:class "op") "#'") "char-equal)") "
" (:span (:id "cb27-5") (:a (:href "#cb27-5" :aria-hidden "true" :tabindex "-1")) "    (make-context-contribution") "
" (:span (:id "cb27-6") (:a (:href "#cb27-6" :aria-hidden "true" :tabindex "-1")) "     :identifier  " (:span (:class "st") "\"release-check\"")) "
" (:span (:id "cb27-7") (:a (:href "#cb27-7" :aria-hidden "true" :tabindex "-1")) "     :instruction " (:span (:class "st") "\"Verify release artifacts before publishing.\"")) "
" (:span (:id "cb27-8") (:a (:href "#cb27-8" :aria-hidden "true" :tabindex "-1")) "     :lifetime    ':turn") "
" (:span (:id "cb27-9") (:a (:href "#cb27-9" :aria-hidden "true" :tabindex "-1")) "     :priority    " (:span (:class "dv") "40") ")))"))))
    "
")
  "
")

(:ul nil
  "
"
  (:li nil "A contributor receives a read-only request snapshot.")
  "
"
  (:li nil "It can return zero, one, or many contributions.")
  "
"
  (:li nil "Notes stack unless they deduplicate, supersede, or conflict.")
  "
"
  (:li nil "Priority matters only when the advice budget is full.")
  "
")

(:p nil "Inspect contributions with " (:code (:class "verbatim") "(context)") ". They apply only to provider requests; they do not count as conversation turns or attach to your messages.")

(:p nil "Register selective project or user advice as a declarative rule:")

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
    (:div (:class "sourceCode" :id "cb28" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb28-1") (:a (:href "#cb28-1" :aria-hidden "true" :tabindex "-1")) "(register-context-rule") "
" (:span (:id "cb28-2") (:a (:href "#cb28-2" :aria-hidden "true" :tabindex "-1")) " '(:id " (:span (:class "st") "\"lisp-edits\"")) "
" (:span (:id "cb28-3") (:a (:href "#cb28-3" :aria-hidden "true" :tabindex "-1")) "   :when (:paths (" (:span (:class "st") "\"src/\"") ") :languages (" (:span (:class "st") "\"common-lisp\"") ")") "
" (:span (:id "cb28-4") (:a (:href "#cb28-4" :aria-hidden "true" :tabindex "-1")) "          :events (" (:span (:class "st") "\"tool-success\"") "))") "
" (:span (:id "cb28-5") (:a (:href "#cb28-5" :aria-hidden "true" :tabindex "-1")) "   :instruction " (:span (:class "st") "\"Check the changed declarations before committing.\"")) "
" (:span (:id "cb28-6") (:a (:href "#cb28-6" :aria-hidden "true" :tabindex "-1")) "   :priority " (:span (:class "dv") "30") " :lifetime :while-relevant))"))))
    "
")
  "
")

(:p nil "Use " (:code (:class "verbatim") ":paths") ", " (:code (:class "verbatim") ":languages") ", " (:code (:class "verbatim") ":tools") ", " (:code (:class "verbatim") ":namespaces") ", " (:code (:class "verbatim") ":roles") ", " (:code (:class "verbatim") ":diagnostics") ", " (:code (:class "verbatim") ":events") " and " (:code (:class "verbatim") ":output-contains") " in " (:code (:class "verbatim") ":when") ". Fields are conjunctive; values within a field are alternatives. Paths match prefixes; " (:code (:class "verbatim") ":output-contains") " matches literal case-insensitive substrings of recent completed assistant text and generated tool arguments. Other values match exactly. Add an absolute " (:code (:class "verbatim") ":workspace") " directory for project scope. Authorized tool operations and structured LSP severities supply bounded current-turn metadata. Asynchronous completions use their originating turn identity. Rules share the ordinary advice budget, priority, lifetime and deduplication policy. Inspect delivery with " (:code (:class "verbatim") "context-status") "; remove a registered rule with " (:code (:class "verbatim") "unregister-context-rule") " and its original ID.")

(:p nil "To turn a complaint into a persistent correction, use:")

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
    (:div (:class "sourceCode" :id "cb29" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb29-1") (:a (:href "#cb29-1" :aria-hidden "true" :tabindex "-1")) "(complain " (:span (:class "st") "\"Your explanations are too long. Give the result first.\"") ")") "
" (:span (:id "cb29-2") (:a (:href "#cb29-2" :aria-hidden "true" :tabindex "-1")) "(wtf " (:span (:class "st") "\"Use the existing library instead of reimplementing it.\"") ")"))))
    "
")
  "
")

(:p nil "Both names open the same interactive review. Inspect the generated instruction and literal trigger, amend the candidate, then choose workspace or global scope to save it. Saving an unmatched trigger and replacing an existing rule each require separate confirmation. Cancel to discard the candidate. Omit the text to enter a complaint in the editor.")

(:p nil "Generation uses bounded recent assistant output and tool arguments as evidence. On later provider requests, matching corrections enter the ordinary request-local advice budget. Inspect them with " (:code (:class "verbatim") "(context)") ". Global corrections are stored in " (:code (:class "verbatim") "data-root/context-rules.sexp") "; workspace collections live under " (:code (:class "verbatim") "data-root/context-rules/") ", keyed by the canonical workspace directory. A same-ID workspace correction overrides the global one in that workspace. Saves take effect on the next request, including in other sessions using the same data root. Edit or remove the data files to change saved collections.")

(:p nil "The status line keeps a context meter visible while idle. It shows used tokens and the full model window. " (:code (:class "verbatim") "|") " marks the automatic compaction point. The ChatGPT subscription catalog currently reports a 272K-token window for the GPT-6.1, GPT-6, and GPT-5.6 models, which compact at about 218K tokens by default:")

(:div (:class "window code-window")
  "
"
  (:div (:class "window-titlebar")
    "
Code
")
  "
"
  (:div (:class "window-body")
    "
"
    (:pre nil (:code nil "ctx [==========|..] 218K / 272K used
"))
    "
")
  "
")

(:p nil "Before provider usage is available, the count uses four characters per token from the known system prompt, request-local guidance, retained conversation, and tool schemas. After compaction it estimates the replacement context until next provider report. Compaction request usage is recorded separately as work spent on the checkpoint.")

(:p nil "If you switch Responses models, the new model receives the conversation and tool exchanges. Encrypted reasoning is available again if you return to the model that produced it.")

(:h3 (:id "compaction") "Compaction")

(:p nil "Use " (:code (:class "verbatim") "(compact)") " to make a checkpoint now. If a turn is active, compaction waits in the idle queue. Automatic compaction uses the same typed checkpoint format. Models from different providers can read the checkpoint. Earlier provider-native windows can still be read by the providers that made them.")

(:p nil "A checkpoint records the current goal, decisions, constraints, completed and open work, uncertainties, and the next step. Recent turns are kept verbatim, normally up to two user turns and 32,768 characters. The latest user message and required tool or reasoning groups can exceed that bound. Live job state, mission policy and the current plan are read separately from their stores.")

(:p nil (:strong nil "Evidence.") " Checkpoint notes can cite messages, tool results, plan steps, mission gates, symbolic facts and unfinished jobs. A completed note without a citation is marked " (:code (:class "verbatim") "(unsubstantiated)") ". Use the " (:code (:class "verbatim") "channel:id/<id>") " address and record sequence to find a message or result. Use " (:code (:class "verbatim") "memory:claim/<id>") " to inspect a fact. After compaction, the next turn reports changes to cited steps, gates and facts. For example, a gate can become stale after an input changes.")

(:p nil "If the model submits an invalid checkpoint, Autolith asks for a correction. After four unsuccessful attempts, it keeps the earlier checkpoint notes and recent turns. It records the range of history that was not summarized. If the provider is unreachable or refuses, or a permission check fails, the conversation is left unchanged.")

(:p nil "A failed checkpoint writes a private report under " (:code (:class "verbatim") "compaction-reports/") " in the state directory. It contains the error and last completed response, with active credentials redacted. In the terminal, use " (:code (:class "verbatim") "(copy bug report to clipboard)") " to copy the report.")

(:h3 (:id "output-limits-and-admission") "Output limits and admission")

(:ul nil
  "
"
  (:li nil (:code (:class "verbatim") "(settings :max-output-tokens 4096)") " caps ordinary model replies. You can also set " (:code (:class "verbatim") "AUTOLITH_MAX_OUTPUT_TOKENS") ". Use " (:code (:class "verbatim") "nil") ", or the text " (:code (:class "verbatim") "none") ", " (:code (:class "verbatim") "off") " or " (:code (:class "verbatim") "unset") ", to use the provider limit.")
  "
"
  (:li nil (:code (:class "verbatim") "(settings :context-output-reserve 8192)") " reserves at least 8,192 tokens for the reply. You can also set " (:code (:class "verbatim") "AUTOLITH_CONTEXT_OUTPUT_RESERVE") ". A larger explicit generation cap takes precedence.")
  "
")

(:p nil "Before sending a request, Autolith checks that the encoded prompt, tools and reply reserve fit within the model window. Cached input counts in full. The most recent compatible provider measurement is used if available. Otherwise Autolith estimates the input size locally.")

(:p nil "Set " (:code (:class "verbatim") "ANALYTICS_EVENTS_FILE") " to export completed streaming calls as UTF-8 JSONL usage events. " (:code (:class "verbatim") "ANALYTICS_ACTOR") " overrides the operating-system username. Each schema-v1 " (:code (:class "verbatim") "llm-usage") " event contains the UTC timestamp, actor, model, request count, elapsed seconds, and known input, output, and cached token counts. Unknown token counts are omitted. Export is disabled without a destination. Appends are synchronous and serialized across processes; export errors do not abort a completed provider call.")

(:p nil "Mechanical precompaction bounds oversized old tool output before a request, but only after an explicitly declared cache lifetime expires or the provider/model changes. A retention estimate alone never permits rewriting served history.")

(:p nil "Excerpts include the head and tail, failure status, uncertainty about external effects, and a retrievable conversation/call reference. Calls, reasoning, and failed attempts are retained. Full outputs are available in the durable transcript; the latest user turn is untouched. Each precompaction is recorded and replayed on resume.")

(:p nil "A same-provider/model resume preserves its prefix unless a known lifetime has elapsed. If a conversation has no recorded response identity, it is prepared once on resume. Manual, context-threshold, and scheduled idle compaction can still replace history with a summary, including when its cache lifetime is unknown.")

(:p nil "Idle cache compaction is enabled by default. After a completed request with at least 32,768 prompt tokens and 131,072 characters of summarizable history, an idle session can compact two minutes before its estimated cache expiry. The timer starts when the request starts, not when its response finishes. User input, drafts, active work and shutdown take priority. Each opportunity is used once, including after failure. Resumed sessions need a new completed request before scheduling one.")

(:p nil "Use " (:code (:class "verbatim") "(settings :idle-compaction-p nil)") " to disable it. The ChatGPT subscription route uses a conservative five-minute inactivity estimate. For Anthropic and OpenRouter Claude, the requested cache lifetime supplies the estimate. Other providers need an explicit estimate for idle compaction, for example " (:code (:class "verbatim") "(settings :prompt-cache-retention-seconds 1800)") " for thirty minutes. A positive value also declares a lifetime for precompaction; this is a user declaration, not evidence from the provider. Set it to zero to use the provider policy. Both settings persist across restarts. The ChatGPT estimate alone never permits idle precompaction; that route has no declared lifetime by default.")

(:p nil (:code (:class "verbatim") "(settings :prompt-cache-ttl :1h)") " asks the Anthropic API and OpenRouter Claude models to keep cache entries for one hour instead of five minutes. A one-hour cache write costs twice the base input price, against 1.25 times for five minutes. The longer lifetime can avoid rewrites after pauses of five minutes to an hour; whether it saves money depends on reuse. Other routes ignore the setting. The requested lifetime supplies both the declared lifetime for precompaction and the estimate for idle compaction. An explicit " (:code (:class "verbatim") ":prompt-cache-retention-seconds") " setting takes precedence for both local policies. OpenRouter requests carry the conversation's cache key as their session identifier for upstream routing affinity from the first request.")

(:p nil "Use " (:code (:class "verbatim") "(status)") " to inspect this process's model-request costs. Autolith uses reported charges when available, as with OpenRouter. Otherwise it uses a model-price snapshot: the built-in Anthropic API list prices, or " (:code (:class "verbatim") "(settings :model-prices \"{\\\"model\\\": {\\\"input\\\": 2, \\\"cache_read\\\": 0.2, \\\"output\\\": 10}}\")") " in US dollars per million tokens, keyed by the model name from " (:code (:class "verbatim") "(model)") ". A missing cache" (:sub nil "write") " rate charges cache writes as input. Requests without a price, such as subscription routes, are counted as unpriced, not free. " (:code (:class "verbatim") "(settings :cost-limit 5)") " refuses new model requests, compaction and inference frames included, once reported and estimated spending reaches five dollars; zero disables the limit. Unpriced requests do not count toward it.")

(:p nil "Cache retention depends on the provider, model, routing and account policy. The " (:a (:href "https://developers.openai.com/api/docs/guides/prompt-caching") "OpenAI API cache documentation") " describes a thirty-minute default for GPT-5.6 and later; it does not establish a retention contract for the ChatGPT subscription route. Idle compaction uses the ordinary paid checkpoint path. It can reduce the context sent after a long pause, but neither a cache hit nor a net saving is guaranteed.")

(:p nil "Use " (:code (:class "verbatim") "(settings :cache-miss-notices-p t)") " to enable notices when cached reads fall by at least 128 tokens, including accumulated smaller losses. Notices also appear when cached reads remain flat while shared request history grows by at least 16,384 characters and at least one sixteenth of its reference size. Temporary context and newly offered history are excluded from shared growth.")

(:p nil "A cache miss reports measured lost reads. A stall reports shared-history growth in characters because its token count is unknown. Both show cached and total input tokens and start with a red " (:code (:class "verbatim") "!") ". Model changes, idle intervals and smaller prompts are local observations, not proof of eviction or routing failure.")

(:p nil "Each notice also identifies changes in the request as sent, compared with the previous request: top-level fields such as " (:code (:class "verbatim") "tools") " or " (:code (:class "verbatim") "system") ", the first item in the previous request's reusable prefix that the new request changes or omits, and moved cache markers.")

(:p nil "The reusable prefix stops before temporary context and one-response exchanges, so appended history does not count as a change. If a request repeats the whole prefix, the notice reads " (:code (:class "verbatim") "prefix intact") ": the provider did not extend its cache. These comparisons use digests of the final request, not provider counters, and retain no prompt text.")

(:p nil "The first request after resuming or compacting establishes a fresh baseline. Without comparable read counters or prefix measurements, no loss is inferred from total input. The setting is off by default and persists across restarts.")

(:p nil "In Responses requests, skill catalogs and selected skill instructions keep their first surviving history position instead of moving after each new message. Autolith reads the current skill contents and checks activation on every request. Selected instructions expire with the logical turn; only the small selection call and result enter durable history. Mutable session state and other ordinary request context follow history. After compaction or removed history boundaries, Autolith places active skill context after the new history. Use " (:code (:class "verbatim") "(context)") " to inspect contribution sizes. Provider cache hits and savings depend on the provider and are not guaranteed.")

(:h2 (:id "providers") "Providers")

(:h3 (:id "run-a-local-model") "Run a local model")

(:p nil "Register local inference servers through the " (:strong nil "OpenAI-compatible Chat Completions") " API. The server must support streaming and the model must support tool calls to use Autolith tools. For an Ollama server on the same machine:")

(:ol nil
  "
"
  (:li nil (:p nil "If Ollama is not already running, start it with " (:code (:class "verbatim") "ollama serve") ". In another terminal, download a model that supports tools:") "
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
        (:div (:class "sourceCode" :id "cb31" :data-org-language "sh")
          (:pre (:class "sourceCode bash") (:code (:class "sourceCode bash") (:span (:id "cb31-1") (:a (:href "#cb31-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "ollama") " pull qwen3:8b"))))
        "
")
      "
"))
  "
"
  (:li nil (:p nil "Add this form to " (:code (:class "verbatim") "${XDG_CONFIG_HOME:-~/.config}/autolith/init.lisp") ":") "
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
        (:div (:class "sourceCode" :id "cb32" :data-org-language "lisp")
          (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb32-1") (:a (:href "#cb32-1" :aria-hidden "true" :tabindex "-1")) "(register-openai-compatible-provider") "
" (:span (:id "cb32-2") (:a (:href "#cb32-2" :aria-hidden "true" :tabindex "-1")) " " (:span (:class "bu") ":name") "                         " (:span (:class "st") "\"local-ollama\"")) "
" (:span (:id "cb32-3") (:a (:href "#cb32-3" :aria-hidden "true" :tabindex "-1")) " :endpoint                     " (:span (:class "st") "\"http://127.0.0.1:11434/v1/chat/completions\"")) "
" (:span (:id "cb32-4") (:a (:href "#cb32-4" :aria-hidden "true" :tabindex "-1")) " :models                       '(" (:span (:class "st") "\"qwen3:8b\"") ")") "
" (:span (:id "cb32-5") (:a (:href "#cb32-5" :aria-hidden "true" :tabindex "-1")) " :api-key-environment-variable " (:span (:class "st") "\"AUTOLITH_OLLAMA_KEY\"")) "
" (:span (:id "cb32-6") (:a (:href "#cb32-6" :aria-hidden "true" :tabindex "-1")) " :stream-usage-p               " (:span (:class "kw") "nil") ")"))))
        "
")
      "
"))
  "
"
  (:li nil (:p nil "Set a nonempty key value and start Autolith. Autolith sends it as a bearer key. Local Ollama ignores it, so " (:code (:class "verbatim") "ollama") " is a placeholder, not a secret.") "
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
        (:div (:class "sourceCode" :id "cb33" :data-org-language "sh")
          (:pre (:class "sourceCode bash") (:code (:class "sourceCode bash") (:span (:id "cb33-1") (:a (:href "#cb33-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "bu") "export") " " (:span (:class "va") "AUTOLITH_OLLAMA_KEY") (:span (:class "op") "=") "ollama") "
" (:span (:id "cb33-2") (:a (:href "#cb33-2" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " models " (:span (:class "kw") "|") " " (:span (:class "fu") "grep") " " (:span (:class "at") "-Fx") " " (:span (:class "st") "'local-ollama/qwen3:8b'")) "
" (:span (:id "cb33-3") (:a (:href "#cb33-3" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " " (:span (:class "at") "--provider") " local-ollama " (:span (:class "at") "--model") " qwen3:8b"))))
        "
")
      "
"))
  "
"
  (:li nil (:p nil "Send a short prompt to check that replies stream. Ask Autolith to list the files in the current directory to check tool calls."))
  "
")

(:p nil "If Ollama runs on another host, " (:code (:class "verbatim") "127.0.0.1") " still refers to the machine that runs Autolith. To keep the remote server private, forward the port over SSH: " (:code (:class "verbatim") "ssh -N -L 11434:127.0.0.1:11434 HOST") ". Use a different local port if 11434 is already in use and change " (:code (:class "verbatim") ":endpoint") " to match.")

(:p nil (:strong nil "Troubleshooting.") " If the model is unknown, check the exact ID with " (:code (:class "verbatim") "ollama list") ". If the server rejects " (:code (:class "verbatim") "stream_options") ", use " (:code (:class "verbatim") ":stream-usage-p nil") " as shown above. If the server runs out of context, increase the context limit on the server first. Then set " (:code (:class "verbatim") ":models") " to a list of model property lists, for example " (:code (:class "verbatim") "'((:name \"qwen3:8b\" :context-window 32768))") " for a server configured with a 32,768-token window. The registration does not change the server limit. See the " (:a (:href "https://docs.ollama.com/api/openai-compatibility") "Ollama API reference") " for supported endpoints.")

(:h3 (:id "add-another-openai-compatible-provider") "Add another OpenAI-compatible provider")

(:p nil "Use the same registration form for a local or hosted service. Change these fields in " (:code (:class "verbatim") "init.lisp") " and restart Autolith:")

(:ul nil
  "
"
  (:li nil (:strong nil "Provider name:") " Set " (:code (:class "verbatim") ":name") " to a unique name for Autolith.")
  "
"
  (:li nil (:strong nil "Endpoint:") " Set " (:code (:class "verbatim") ":endpoint") " to the full streaming Chat Completions URL, typically ending in " (:code (:class "verbatim") "/v1/chat/completions") ".")
  "
"
  (:li nil (:strong nil "Models:") " Set " (:code (:class "verbatim") ":models") " to the IDs you want to use, " (:code (:class "verbatim") ":models-endpoint") " to the full model-list URL, or both. Use static IDs if you want to select a model on the first launch. Inside Autolith, use " (:code (:class "verbatim") "(models :provider \"my-provider\")") " to refresh the model list from the service.")
  "
"
  (:li nil (:strong nil "Credentials:") " Set " (:code (:class "verbatim") ":api-key-environment-variable") " to the name of a variable that contains the service key, or run " (:code (:class "verbatim") "autolith auth my-provider") " to store the key privately. A nonempty environment value takes precedence. Replace " (:code (:class "verbatim") "my-provider") " with your registration name.")
  "
")

(:p nil "Optional " (:code (:class "verbatim") ":headers") " adds non-secret HTTP headers. If the server supports the streaming usage chunk, you can omit " (:code (:class "verbatim") ":stream-usage-p") " to request it.")

(:p nil "For a different wire protocol, use the Lisp extension point " (:code (:class "verbatim") "register-provider") " with a factory that returns a " (:code (:class "verbatim") "model-provider") ". The Chat Completions helper always uses Chat Completions.")

(:p nil "Select a model with " (:code (:class "verbatim") "(model \"glm-5.3-flash\" :provider \"neuralwatt\")") " or " (:code (:class "verbatim") "(model \"neuralwatt/glm-5.3-flash\")") ". Use " (:code (:class "verbatim") "(models :provider \"neuralwatt\")") " to refresh and list one provider, or " (:code (:class "verbatim") "(model nil :provider \"neuralwatt\")") " to filter the interactive picker. The picker and listings show the provider with each model, including identical IDs offered by different providers.")

(:p nil "Bare model IDs use the existing registration precedence. Only a registered provider name introduces a provider prefix; catalog IDs containing slashes, such as " (:code (:class "verbatim") "hf:zai-org/GLM-5.3-Flash") ", are matched intact. If a catalog ID also looks like another provider's full ID, specify " (:code (:class "verbatim") ":provider") " to select its exact catalog ID. An explicit provider and a conflicting qualified prefix signal a selection error. The selected provider is saved with the model in preferences and conversation history, so reopening a session uses the same registration.")

(:p nil "Select a model for one launch with " (:code (:class "verbatim") "--model MODEL") ". Use a provider-qualified ID, or pass " (:code (:class "verbatim") "--provider PROVIDER") " together with " (:code (:class "verbatim") "--model") " for an exact catalog ID. These options work before or after " (:code (:class "verbatim") "run-job") " and " (:code (:class "verbatim") "open") ":")

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
    (:div (:class "sourceCode" :id "cb34" :data-org-language "sh")
      (:pre (:class "sourceCode bash") (:code (:class "sourceCode bash") (:span (:id "cb34-1") (:a (:href "#cb34-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " " (:span (:class "at") "--model") " my-provider/my-model") "
" (:span (:id "cb34-2") (:a (:href "#cb34-2" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " " (:span (:class "at") "--provider") " my-provider " (:span (:class "at") "--model") " hf:custom/model") "
" (:span (:id "cb34-3") (:a (:href "#cb34-3" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " open " (:span (:class "at") "--model") " my-provider/my-model") "
" (:span (:id "cb34-4") (:a (:href "#cb34-4" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " run-job " (:span (:class "at") "--model") " my-provider/my-model " (:span (:class "at") "--input") " job.sexp " (:span (:class "at") "--output") " result.sexp"))))
    "
")
  "
")

(:p nil "The launch selection takes precedence over environment variables, saved preferences, and a resumed conversation's model. It does not save a new default; use " (:code (:class "verbatim") "(model ...)") " to save a selection. Autolith loads executable initialization and the local provider catalog before validating the requested model, so providers registered in " (:code (:class "verbatim") "init.lisp") " are available. Startup does not fetch a remote catalog; use " (:code (:class "verbatim") "autolith models") " to list locally known IDs and " (:code (:class "verbatim") "(models)") " to refresh them.")

(:h3 (:id "model-catalogs-and-sign-in") "Model catalogs and sign-in")

(:p nil "Startup uses built-in model metadata and the last successful local catalog. It makes no catalog request. Use " (:code (:class "verbatim") "(models)") " to refresh the picker. For several built-in providers, Autolith reads public metadata from " (:a (:href "https://models.dev/") "models.dev") ". Custom registrations use the discovery URL that you configure. Copilot and Nous use account-specific catalogs. Subscription clients list models that the transport supports, which can differ from the public API catalog.")

(:p nil "Built-in ChatGPT subscriptions use browser OAuth with PKCE and a local callback on " (:code (:class "verbatim") "localhost:1455") " or " (:code (:class "verbatim") "localhost:1457") " by default. Use " (:code (:class "verbatim") "(auth \"chatgpt\" :device-code)") " or " (:code (:class "verbatim") "autolith auth chatgpt device") " to select the device-code flow instead. The browser authorization URL is always printed for manual use. Grok and Nous Research use browser device flows. Gemini uses Google installed-application OAuth with a local loopback callback. Use an API key for Anthropic, Fireworks, OpenCode, OpenRouter, Mistral, OpenAI API and custom OpenAI-compatible providers.")

(:p nil "The direct Anthropic catalog includes " (:code (:class "verbatim") "claude-fable-5-2") ", " (:code (:class "verbatim") "claude-opus-5-5") ", " (:code (:class "verbatim") "claude-sonnet-5-5") " and " (:code (:class "verbatim") "claude-haiku-5-5") " with one-million-token context windows. For these models, " (:code (:class "verbatim") "reasoning-effort") " selects " (:code (:class "verbatim") "low") ", " (:code (:class "verbatim") "medium") ", " (:code (:class "verbatim") "high") ", " (:code (:class "verbatim") "xhigh") " or " (:code (:class "verbatim") "max") " through adaptive thinking. Haiku 5.5 price estimates use its reported prompt length: the lower tier applies through 100,000 input tokens.")

(:p nil "Autolith retains dispatched Anthropic messages in memory across tool rounds, new user input and request-local context changes. New input and changed context follow the dispatched prefix. Requests use at most four cache breakpoints across system instructions, tools and messages. Changed headers, rewritten history, compaction and ephemeral exchanges start a fresh projection. For a specifically identified thinking prefix-binding HTTP 400, Autolith retries once with Anthropic's binding control. The conversation log stores up to 32 rejected signature digests. Later requests use the control only while a rejected block is present and the effective thinking mode supports it. See Anthropic's " (:a (:href "https://platform.claude.com/docs/en/build-with-claude/preserved-thinking/prefix-checks") "prefix checks") " and " (:a (:href "https://platform.claude.com/docs/en/build-with-claude/effort") "effort guide") ".")

(:p nil "OpenCode Go and Zen have separate provider selections and catalogs. Use " (:code (:class "verbatim") "(auth \"opencode-go\")") " for Go and " (:code (:class "verbatim") "(auth \"opencode-zen\")") " for Zen. The old " (:code (:class "verbatim") "opencode") " provider name is an alias for Go; existing " (:code (:class "verbatim") "opencode/...") " model IDs, " (:code (:class "verbatim") "OPENCODE_API_KEY") ", and saved Go credentials keep their Go routing. Zen models use " (:code (:class "verbatim") "opencode-zen/...") " IDs and " (:code (:class "verbatim") "OPENCODE_ZEN_API_KEY") " or a separately saved key. Refresh with " (:code (:class "verbatim") "(models)") " to load each tier's context windows and available models.")

(:p nil "Go uses " (:code (:class "verbatim") "https://opencode.ai/inference/go/openai/v1") " and Zen uses " (:code (:class "verbatim") "https://opencode.ai/inference/openai/v1") ". Both use Chat Completions. To override Go's endpoints, set " (:code (:class "verbatim") "AUTOLITH_OPENCODE_PROVIDER_ENDPOINT") " and " (:code (:class "verbatim") "AUTOLITH_OPENCODE_MODELS_ENDPOINT") ". For Zen, set " (:code (:class "verbatim") "AUTOLITH_OPENCODE_ZEN_PROVIDER_ENDPOINT") " and " (:code (:class "verbatim") "AUTOLITH_OPENCODE_ZEN_MODELS_ENDPOINT") ". Chat endpoint overrides include " (:code (:class "verbatim") "/chat/completions") "; discovery endpoint overrides include " (:code (:class "verbatim") "/models") ".")

(:p nil "For the official OpenAI API, choose " (:code (:class "verbatim") "openai-api") " during onboarding, run " (:code (:class "verbatim") "autolith auth openai-api") ", or use " (:code (:class "verbatim") "(auth \"openai-api\")") ". Paste your API key at the hidden prompt. Autolith stores it in its private credential store and loads the models available to that key from " (:code (:class "verbatim") "https://api.openai.com/v1/models") ". Requests use " (:code (:class "verbatim") "https://api.openai.com/v1/responses") ". No " (:code (:class "verbatim") "init.lisp") " registration is needed. The " (:code (:class "verbatim") "chatgpt") " provider uses a ChatGPT subscription instead.")

(:p nil "Authenticate a GitHub Copilot subscription with " (:code (:class "verbatim") "autolith auth copilot") " or " (:code (:class "verbatim") "(auth \"copilot\")") ". Approve the displayed device code at GitHub. Credentials are stored in the private " (:code (:class "verbatim") "copilot-auth.sexp") " under the state root. Tokens renew automatically before expiry.")

(:p nil "Login discovers tool-capable picker models and " (:code (:class "verbatim") "copilot/auto") ", and attempts to enable unconfigured picker models. Models are named " (:code (:class "verbatim") "copilot/<model-id>") " locally to avoid collisions with direct vendor subscriptions. Successful Copilot login selects Auto and saves it as the default, unless the current Copilot model is still available. Use " (:code (:class "verbatim") "(models)") " to refresh the catalog, then " (:code (:class "verbatim") "(model \"copilot/auto\")") " to select Auto on an existing installation, or launch with " (:code (:class "verbatim") "--model copilot/auto") ". Normal startup reads the last successful catalog without a network request.")

(:p nil "Use Auto with Copilot Student or Free plans, which do not offer manual model selection. Each request resolves an account-authorized concrete model and uses its Chat Completions, Responses, or Messages protocol with a short-lived session token. Auto keeps the previous concrete model while it is available. Hidden named models are not offered as manual choices. For other plans, select an available named model with " (:code (:class "verbatim") "(model)") ". Disabled picker models are excluded.")

(:p nil "For GitHub Enterprise Cloud with data residency, set " (:code (:class "verbatim") "AUTOLITH_COPILOT_DOMAIN") " to your " (:code (:class "verbatim") "TENANT.ghe.com") " hostname during both login and subsequent launches. Tokens are pinned to that host and streams use the subscription-specific endpoint returned by Copilot. Chat Completions, Responses, and Anthropic Messages reuse the existing transports. This integration uses GitHub's internal Copilot endpoints, following pi and VS Code, so it may require updates when GitHub changes that service.")

(:p nil "ChatGPT models use Codex's default context windows, currently 272,000 tokens, instead of public OpenAI API limits from models.dev. In " (:code (:class "verbatim") "(settings)") ", toggle " (:code (:class "verbatim") "prefer-codex-context-window-p") " off to use public catalog limits, or evaluate " (:code (:class "verbatim") "(setf (config :prefer-codex-context-window-p) nil)") ". This saved choice applies only to the built-in ChatGPT provider. Set " (:code (:class "verbatim") "AUTOLITH_PREFER_CODEX_CONTEXT_WINDOW=off") " to override it for one process. " (:code (:class "verbatim") "AUTOLITH_CONTEXT_WINDOW") " takes precedence over both sources. Compaction uses " (:code (:class "verbatim") "compaction-threshold-percent") " of the selected window, 80% by default. The requests of a compaction are checked against the model's catalog limit when that is larger than the selected window, since compacting is how a conversation gets back under it. This holds for every provider and for a window set through " (:code (:class "verbatim") "AUTOLITH_CONTEXT_WINDOW") ".")

(:p nil "ChatGPT Codex Fast mode sends " (:code (:class "verbatim") "service_tier=priority") " when the active Codex model advertises Fast support. Fast responses count more heavily against plan usage; the exact rate is set by OpenAI per model and is not tracked here. The built-in GPT-6.1, GPT-6, and GPT-5.6 models support it. Set " (:code (:class "verbatim") ":codex-fast-mode-p") " with " (:code (:class "verbatim") "(settings)") ". Other providers and unknown Codex models use the standard path. Set " (:code (:class "verbatim") "AUTOLITH_CODEX_FAST_MODE") " to " (:code (:class "verbatim") "on") " or " (:code (:class "verbatim") "off") " to override the saved choice for one process.")

(:p nil "If a request fails before model generation begins, Autolith retries it up to six times with jittered delays.")

(:p nil "Once reasoning or output has streamed, or the provider reports token exhaustion (" (:code (:class "verbatim") "length") ", " (:code (:class "verbatim") "max_output_tokens") ", or " (:code (:class "verbatim") "max_tokens") "), Autolith makes at most two retries: three generation attempts including the original. Token exhaustion before visible text uses the same limit.")

(:p nil "Set " (:code (:class "verbatim") "autolith::*provider-maximum-streaming-retries*") " in " (:code (:class "verbatim") "init.lisp") " to change this retry count; zero disables these retries.")

(:p nil "Every failed attempt is recorded next to its request number with the attempt count, elapsed seconds, whether output was received, and provider identifiers.")

(:p nil "ChatGPT Codex uses standard Responses requests and native Responses compaction. Normal requests enable provider parallel tool calls. Autolith executes independent calls concurrently, then records their results in provider wire order. Calls requiring a provider round trip, exclusive tools, and calls sharing one mutable runtime execute in separate ordered waves.")

(:p nil "GPT-5.4 and later Codex models use native Responses tool search. Autolith sends stable namespace names and descriptions up front, marks each function " (:code (:class "verbatim") "defer_loading=true") ", and declares a client-executed " (:code (:class "verbatim") "tool_search") ".")

(:p nil "When the model searches, Autolith searches its own registry within the namespaces advertised in that request. It scores namespace names, tool names, and description words, then appends the " (:code (:class "verbatim") "tool_search_output") " as a durable provider item.")

(:p nil "The expansion replays intact in every later request. This keeps those tools loaded and the prompt prefix cacheable. Other models and providers receive the complete eager tool array.")

(:p nil "Authenticate Gemini with " (:code (:class "verbatim") "autolith auth gemini") " or " (:code (:class "verbatim") "(auth \"gemini\")") ". Autolith stores its Google OAuth credentials separately at " (:code (:class "verbatim") "gemini-auth.sexp") " under the state root. The provider uses the Gemini CLI Code Assist subscription service directly, including streaming text and thinking, tool calls, token usage, account onboarding, and managed companion projects. " (:code (:class "verbatim") "AUTOLITH_GEMINI_OAUTH_CLIENT_ID") " may replace the public installed-application client ID; " (:code (:class "verbatim") "AUTOLITH_GEMINI_OAUTH_CLIENT_SECRET") " supplies a client secret when a deployment requires one.")

(:p nil "Use " (:code (:class "verbatim") "vertex-gemini") " or " (:code (:class "verbatim") "vertex-anthropic") " for paid Google Vertex AI access. Create local application default credentials with gcloud:")

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
    (:div (:class "sourceCode" :id "cb35" :data-org-language "sh")
      (:pre (:class "sourceCode bash") (:code (:class "sourceCode bash") (:span (:id "cb35-1") (:a (:href "#cb35-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "gcloud") " auth application-default login") "
" (:span (:id "cb35-2") (:a (:href "#cb35-2" :aria-hidden "true" :tabindex "-1")) (:span (:class "bu") "export") " " (:span (:class "va") "GOOGLE_CLOUD_PROJECT") (:span (:class "op") "=") "your-project-id") "
" (:span (:id "cb35-3") (:a (:href "#cb35-3" :aria-hidden "true" :tabindex "-1")) (:span (:class "bu") "export") " " (:span (:class "va") "GOOGLE_CLOUD_LOCATION") (:span (:class "op") "=") "global") "
" (:span (:id "cb35-4") (:a (:href "#cb35-4" :aria-hidden "true" :tabindex "-1"))) "
" (:span (:id "cb35-5") (:a (:href "#cb35-5" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " " (:span (:class "at") "--model") " vertex-gemini/gemini-3.5-flash") "
" (:span (:id "cb35-6") (:a (:href "#cb35-6" :aria-hidden "true" :tabindex "-1")) (:span (:class "co") "# Or:")) "
" (:span (:id "cb35-7") (:a (:href "#cb35-7" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " " (:span (:class "at") "--model") " vertex-anthropic/claude-sonnet-4-6"))))
    "
")
  "
")

(:p nil "Enable billing and the Vertex AI API for that project. Your account needs " (:code (:class "verbatim") "aiplatform.endpoints.predict") " permission, such as the Vertex AI User role. For Claude, enable the model in Model Garden. Choose a location where the model is available; " (:code (:class "verbatim") "global") " is the default.")

(:p nil "Autolith reads local " (:code (:class "verbatim") "authorized_user") " ADC files. It checks " (:code (:class "verbatim") "GOOGLE_APPLICATION_CREDENTIALS") " first, then " (:code (:class "verbatim") "CLOUDSDK_CONFIG") ", then gcloud's usual config directory. Run " (:code (:class "verbatim") "gcloud auth application-default login") " even if you have already run " (:code (:class "verbatim") "gcloud auth login") ". Service-account, federation, and metadata-server credentials are not supported by this adapter.")

(:p nil "Each request exchanges a fresh access token. Autolith does not copy or write ADC credentials. Use " (:code (:class "verbatim") "GOOGLE_CLOUD_QUOTA_PROJECT") " to override the ADC quota project. The settings " (:code (:class "verbatim") ":vertex-project") ", " (:code (:class "verbatim") ":vertex-location") ", and " (:code (:class "verbatim") ":vertex-quota-project") " provide the same routing choices in " (:code (:class "verbatim") "init.lisp") ".")

(:p nil "Run " (:code (:class "verbatim") "autolith auth vertex-gemini") " or " (:code (:class "verbatim") "autolith auth vertex-anthropic") " to check the local ADC token exchange. This does not check model access. Send a prompt to test project permissions, billing, location, and model access.")

(:p nil "See Google's " (:a (:href "https://docs.cloud.google.com/docs/authentication/application-default-credentials") "ADC guide") " and Anthropic's " (:a (:href "https://platform.claude.com/docs/en/build-with-claude/claude-models-on-google-cloud/google-managed") "Vertex guide") " for cloud setup.")

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
    (:div (:class "sourceCode" :id "cb36" :data-org-language "sh")
      (:pre (:class "sourceCode bash") (:code (:class "sourceCode bash") (:span (:id "cb36-1") (:a (:href "#cb36-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " auth nous"))))
    "
")
  "
")

(:p nil "Nous models are discovered from the authenticated account. Run " (:code (:class "verbatim") "(models)") " after login to refresh the catalog. Model identifiers beginning with " (:code (:class "verbatim") "anthropic/") " use the native Anthropic Messages route; the rest use OpenAI-compatible Chat Completions. Hermes model identifiers are omitted from the catalog because they are not reliable for agentic tool calling.")

(:p nil "The Nous integration accepts three deployment overrides:")

(:ul nil
  "
"
  (:li nil (:code (:class "verbatim") "AUTOLITH_NOUS_PORTAL_URL") " selects the OAuth portal.")
  "
"
  (:li nil (:code (:class "verbatim") "AUTOLITH_NOUS_INFERENCE_BASE_URL") " selects the " (:code (:class "verbatim") "/v1") " inference base used for model discovery, Chat Completions, and Messages.")
  "
"
  (:li nil (:code (:class "verbatim") "AUTOLITH_NOUS_PROVIDER_ENDPOINT") " overrides only the Chat Completions endpoint.")
  "
")

(:p nil "Autolith stores Nous OAuth state separately at " (:code (:class "verbatim") "nous-auth.sexp") " under its state root and serializes rotating refresh-token updates across processes sharing that root.")

(:p nil "Mistral models come from models.dev and support tool calls and text output. " (:code (:class "verbatim") "MISTRAL_API_KEY") " takes precedence over Autolith's private Mistral key. " (:code (:class "verbatim") "AUTOLITH_MISTRAL_PROVIDER_ENDPOINT") " and " (:code (:class "verbatim") "AUTOLITH_MISTRAL_MODELS_ENDPOINT") " override the chat and discovery endpoints independently.")

(:p nil "OpenRouter models come from models.dev and use " (:code (:class "verbatim") "openrouter/<vendor>/<model>") " identifiers locally. The picker includes models that emit text and advertise tool calls. " (:code (:class "verbatim") "OPENROUTER_API_KEY") " takes precedence over Autolith's private OpenRouter key. Authenticate with " (:code (:class "verbatim") "autolith auth openrouter") " or " (:code (:class "verbatim") "(auth \"openrouter\")") ". " (:code (:class "verbatim") "AUTOLITH_OPENROUTER_PROVIDER_ENDPOINT") " and " (:code (:class "verbatim") "AUTOLITH_OPENROUTER_MODELS_ENDPOINT") " override the chat and discovery endpoints independently.")

(:p nil "Set " (:code (:class "verbatim") ":openrouter-provider-routing") " to a JSON map of wire model names to OpenRouter provider preference objects. Omit the local " (:code (:class "verbatim") "openrouter/") " prefix from model keys. Use " (:code (:class "verbatim") "*") " for models without their own entry. For example:")

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
    (:div (:class "sourceCode" :id "cb37" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb37-1") (:a (:href "#cb37-1" :aria-hidden "true" :tabindex "-1")) "(" (:span (:class "kw") "setf") " (config :openrouter-provider-routing)") "
" (:span (:id "cb37-2") (:a (:href "#cb37-2" :aria-hidden "true" :tabindex "-1")) "      " (:span (:class "st") "\"{") (:span (:class "sc") "\\\"") (:span (:class "st") "deepseek/deepseek-v4.1-flash") (:span (:class "sc") "\\\"") (:span (:class "st") ":{") (:span (:class "sc") "\\\"") (:span (:class "st") "order") (:span (:class "sc") "\\\"") (:span (:class "st") ":[") (:span (:class "sc") "\\\"") (:span (:class "st") "baseten") (:span (:class "sc") "\\\"") (:span (:class "st") ",") (:span (:class "sc") "\\\"") (:span (:class "st") "together") (:span (:class "sc") "\\\"") (:span (:class "st") "],") (:span (:class "sc") "\\\"") (:span (:class "st") "allow_fallbacks") (:span (:class "sc") "\\\"") (:span (:class "st") ":true}}\"") ")"))))
    "
")
  "
")

(:p nil "You can also supply this JSON through " (:code (:class "verbatim") "AUTOLITH_OPENROUTER_PROVIDER_ROUTING") ". Supply an empty string to use OpenRouter's normal routing. Provider preference fields are sent as supplied, including " (:code (:class "verbatim") "order") ", " (:code (:class "verbatim") "allow_fallbacks") ", " (:code (:class "verbatim") "only") ", " (:code (:class "verbatim") "ignore") ", " (:code (:class "verbatim") "sort") ", and " (:code (:class "verbatim") "max_price") ".")

(:h2 (:id "commands") "Commands")

(:p nil "Put commands in " (:code (:class "verbatim") "${XDG_CONFIG_HOME:-~/.config}/autolith/init.lisp") " or load a Lisp file from there. Autolith loads user initialization after tracked code on ordinary startup, including after updates. Use " (:code (:class "verbatim") "define-application-command") " to register the command and set its help, completion and dispatch policies.")

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
    (:div (:class "sourceCode" :id "cb38" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb38-1") (:a (:href "#cb38-1" :aria-hidden "true" :tabindex "-1")) "(define-application-command my-version-command") "
" (:span (:id "cb38-2") (:a (:href "#cb38-2" :aria-hidden "true" :tabindex "-1")) "    (" (:span (:class "bu") ":name") "              " (:span (:class "st") "\"my-version\"")) "
" (:span (:id "cb38-3") (:a (:href "#cb38-3" :aria-hidden "true" :tabindex "-1")) "     :aliases           (" (:span (:class "st") "\"local-version\"") ")") "
" (:span (:id "cb38-4") (:a (:href "#cb38-4" :aria-hidden "true" :tabindex "-1")) "     :argument          " (:span (:class "st") "\"[LABEL]\"")) "
" (:span (:id "cb38-5") (:a (:href "#cb38-5" :aria-hidden "true" :tabindex "-1")) "     :description       " (:span (:class "st") "\"show a labeled local integration version\"")) "
" (:span (:id "cb38-6") (:a (:href "#cb38-6" :aria-hidden "true" :tabindex "-1")) "     :tip               " (:span (:class "st") "\"shows the version supplied by init.lisp.\"")) "
" (:span (:id "cb38-7") (:a (:href "#cb38-7" :aria-hidden "true" :tabindex "-1")) "     :busy-behavior     :execute") "
" (:span (:id "cb38-8") (:a (:href "#cb38-8" :aria-hidden "true" :tabindex "-1")) "     :terminal-behavior :shared") "
" (:span (:id "cb38-9") (:a (:href "#cb38-9" :aria-hidden "true" :tabindex "-1")) "     :callable          " (:span (:class "kw") "t") ")") "
" (:span (:id "cb38-10") (:a (:href "#cb38-10" :aria-hidden "true" :tabindex "-1")) "    (application " (:span (:class "op") "&optional") " (label " (:span (:class "st") "\"integration\"") "))") "
" (:span (:id "cb38-11") (:a (:href "#cb38-11" :aria-hidden "true" :tabindex "-1")) "  (application-present application (" (:span (:class "kw") "format") " " (:span (:class "kw") "nil") " " (:span (:class "st") "\"~A 3\"") " label))") "
" (:span (:id "cb38-12") (:a (:href "#cb38-12" :aria-hidden "true" :tabindex "-1")) "  :continue)"))))
    "
")
  "
")

(:ul nil
  "
"
  (:li nil (:strong nil "Arguments:") " Callable handlers take ordinary Lisp lambda lists, including " (:code (:class "verbatim") "&key") " and supplied-p parameters. Missing interactive arguments open the restart debugger. Use " (:code (:class "verbatim") "supply-arguments") " to pass replacement Lisp values. Autolith rejects excess arguments before dispatch.")
  "
"
  (:li nil (:strong nil "Busy behavior:") " Choose " (:code (:class "verbatim") ":inspect") ", " (:code (:class "verbatim") ":execute") ", " (:code (:class "verbatim") ":apply") ", " (:code (:class "verbatim") ":hold") " or " (:code (:class "verbatim") ":cancel") ". Use " (:code (:class "verbatim") ":execute") " to run immediately, " (:code (:class "verbatim") ":apply") " to change state at the next safe provider boundary, or " (:code (:class "verbatim") ":hold") " to wait for idle. Argument-free " (:code (:class "verbatim") ":inspect") " and " (:code (:class "verbatim") ":apply") " invocations can show state immediately.")
  "
"
  (:li nil (:strong nil "Terminal behavior:") " Choose " (:code (:class "verbatim") ":shared") ", " (:code (:class "verbatim") ":exclusive") " or " (:code (:class "verbatim") ":exclusive-without-arguments") " to specify which calls need exclusive input. A modal picker that changes state under " (:code (:class "verbatim") ":inspect") " or " (:code (:class "verbatim") ":apply") " waits for idle. A picker under " (:code (:class "verbatim") ":execute") " can open during inference.")
  "
"
  (:li nil (:strong nil "Fixed options:") " Use " (:code (:class "verbatim") ":static-options") " instead of " (:code (:class "verbatim") ":argument") " for one positional choice. Supply strings, keywords or " (:code (:class "verbatim") "(t nil)") " for a boolean choice. Autolith uses these values in help and completion.")
  "
")

(:h2 (:id "live-definitions") "Live definitions")

(:p nil "Use " (:code (:class "verbatim") "self.define") " to add or replace a loaded Lisp definition. Qualify the symbol or set " (:code (:class "verbatim") "package") " to choose the reader package. Use qualified symbols with " (:code (:class "verbatim") "self.set") " when changing global bindings in other packages. Autolith restores package locks after installation, discard or replay.")

(:p nil "Use " (:code (:class "verbatim") "self.eval") " to evaluate in the active image. In a world, that is the server image. Set " (:code (:class "verbatim") "target") " to " (:code (:class "verbatim") "client") " to evaluate in the controlling terminal or, if there is no eligible terminal, the most recently attached eligible structured client. The client must advertise Lisp evaluation. Client evaluations are not journaled and do not survive the client process.")

(:p nil (:strong nil "Tracked source takes precedence.") " On startup, Autolith skips a private definition if the tracked definition changed, appeared or disappeared, or if ownership moved to another library. A startup notice groups skips by reason. The next " (:code (:class "verbatim") "self.commit") " omits skipped definitions. For older commits without this metadata, tracked overrides replay only on the source revision used to publish the lineage.")

(:p nil "Reapply a skipped definition against the current source to keep it. Or run " (:code (:class "verbatim") "(fix-skipped-definitions)") " to give the model the private, old tracked and current tracked versions. By default it rebuilds overrides that are still needed and publishes the result with " (:code (:class "verbatim") "self.commit") ". An optional comment takes precedence over that policy. If a turn is active, the command waits for idle.")

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
    (:div (:class "sourceCode" :id "cb39" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb39-1") (:a (:href "#cb39-1" :aria-hidden "true" :tabindex "-1")) "(fix-skipped-definitions " (:span (:class "st") "\"Drop all of these. They were temporary development experiments.\"") ")"))))
    "
")
  "
")

(:h2 (:id "refinement") "Refinement")

(:p nil "Use " (:code (:class "verbatim") "(refine)") " to inspect proposals. Record a local task assessment before promotion:")

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
    (:div (:class "sourceCode" :id "cb40" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb40-1") (:a (:href "#cb40-1" :aria-hidden "true" :tabindex "-1")) "(refine :assess " (:span (:class "st") "\"PROPOSAL-ID\"") " :revision " (:span (:class "dv") "3") " :verdict :passed") "
" (:span (:id "cb40-2") (:a (:href "#cb40-2" :aria-hidden "true" :tabindex "-1")) "        :evidence " (:span (:class "st") "\"Evidence from a separate task\"") ")"))))
    "
")
  "
")

(:p nil "Promote from session to project to global scope. Each step requires renewed evaluation and checks for intervening owner changes. If an operation was interrupted, use the recorded evidence to recover it explicitly. Replay does not repeat the operation.")

(:h2 (:id "executable-skills") "Executable Skills")

(:p nil "Use " (:code (:class "verbatim") "skill.load") " with the exact catalog name to load instructions for the current turn. Use " (:code (:class "verbatim") "resource.read") " on " (:code (:class "verbatim") "skill:NAME") " if you need the full catalog description.")

(:ol nil
  "
"
  (:li nil (:p nil "Put a data-only " (:code (:class "verbatim") "EXECUTABLE.sexp") " beside " (:code (:class "verbatim") "SKILL.md") " or " (:code (:class "verbatim") "SKILL.sexp") ". Declare the Skill and ASDF system versions, entrypoint, contracts, capabilities and exact host tool names.") "
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
        (:div (:class "sourceCode" :id "cb41" :data-org-language "lisp")
          (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb41-1") (:a (:href "#cb41-1" :aria-hidden "true" :tabindex "-1")) "(:skill-executable :format-version " (:span (:class "dv") "1") " :skill-version " (:span (:class "st") "\"1.0.0\"")) "
" (:span (:id "cb41-2") (:a (:href "#cb41-2" :aria-hidden "true" :tabindex "-1")) " :system " (:span (:class "st") "\"my-workflow\"") " :system-version " (:span (:class "st") "\"1.0.0\"")) "
" (:span (:id "cb41-3") (:a (:href "#cb41-3" :aria-hidden "true" :tabindex "-1")) " :entrypoint (" (:span (:class "st") "\"MY-WORKFLOW\"") " " (:span (:class "st") "\"RUN\"") ")") "
" (:span (:id "cb41-4") (:a (:href "#cb41-4" :aria-hidden "true" :tabindex "-1")) " :self-test (" (:span (:class "st") "\"MY-WORKFLOW\"") " " (:span (:class "st") "\"SELF-TEST\"") ")") "
" (:span (:id "cb41-5") (:a (:href "#cb41-5" :aria-hidden "true" :tabindex "-1")) " :verify (" (:span (:class "st") "\"MY-WORKFLOW\"") " " (:span (:class "st") "\"VERIFY\"") ")") "
" (:span (:id "cb41-6") (:a (:href "#cb41-6" :aria-hidden "true" :tabindex "-1")) " :capabilities (" (:span (:class "st") "\"workspace-read\"") ") :tools (" (:span (:class "st") "\"resource.read\"") ")") "
" (:span (:id "cb41-7") (:a (:href "#cb41-7" :aria-hidden "true" :tabindex "-1")) " " (:span (:class "bu") ":input") " (" (:span (:class "bu") ":type") " :object) " (:span (:class "bu") ":output") " (" (:span (:class "bu") ":type") " :object))"))))
        "
")
      "
"))
  "
"
  (:li nil (:p nil "Define the entrypoint with " (:code (:class "verbatim") "input &key context") ". Use " (:code (:class "verbatim") "&key context") " for self-test and verification functions. Use portable JSON values such as " (:code (:class "verbatim") "(:object (\"status\" \"ready\"))") " for input and output."))
  "
"
  (:li nil (:p nil "Install the ASDF system in the worker environment or pass an authorized " (:code (:class "verbatim") "asd") " pathname. Call " (:code (:class "verbatim") "skill.invoke") " with contract-valid " (:code (:class "verbatim") "input") ":") "
" (:div (:class "window code-window")
      "
"
      (:div (:class "window-titlebar")
        "
JSON
")
      "
"
      (:div (:class "window-body")
        "
"
        (:div (:class "sourceCode" :id "cb42")
          (:pre (:class "sourceCode json") (:code (:class "sourceCode json") (:span (:id "cb42-1") (:a (:href "#cb42-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "fu") "{") (:span (:class "dt") "\"name\"") (:span (:class "fu") ":") (:span (:class "st") "\"my-workflow\"") (:span (:class "fu") ",") (:span (:class "dt") "\"input\"") (:span (:class "fu") ":{},")) "
" (:span (:id "cb42-2") (:a (:href "#cb42-2" :aria-hidden "true" :tabindex "-1")) " " (:span (:class "dt") "\"asd\"") (:span (:class "fu") ":") (:span (:class "st") "\".autolith/skills/my-workflow/my-workflow.asd\"") (:span (:class "fu") ",") (:span (:class "dt") "\"async\"") (:span (:class "fu") ":") (:span (:class "kw") "true") (:span (:class "fu") "}")))))
        "
")
      "
"))
  "
")

(:p nil "Use " (:code (:class "verbatim") "skill.verify") " with " (:code (:class "verbatim") "name") " to run the self-test. Set " (:code (:class "verbatim") "entrypoint") " to " (:code (:class "verbatim") "verify") " to run the verification function instead. Both tools require explicit full-access code authorization and run in a fresh worker. A worker can call only the declared host tools that the originating agent may use. Autolith rechecks source, manifest and ASDF version before execution.")

(:p nil "Use " (:code (:class "verbatim") "async: true") " for a managed job. Autolith validates the result against the output contract and retains up to 1 MiB of data with the executable identity.")

(:h2 (:id "local-text-redaction") "Local text redaction")

(:p nil "Use " (:code (:class "verbatim") "(redact text)") " in the user REPL. From " (:code (:class "verbatim") "lisp.eval") " or a scratchpad, use " (:code (:class "verbatim") "autolith:redact") ".")

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
    (:div (:class "sourceCode" :id "cb43" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb43-1") (:a (:href "#cb43-1" :aria-hidden "true" :tabindex "-1")) "(redact " (:span (:class "st") "\"Alice Smith lives in Amsterdam.\"") ")") "
" (:span (:id "cb43-2") (:a (:href "#cb43-2" :aria-hidden "true" :tabindex "-1")) "(redact text :language " (:span (:class "st") "\"en\"") ")"))))
    "
")
  "
")

(:p nil "Read both return values: the redacted string and " (:code (:class "verbatim") ":ok") " on success, or " (:code (:class "verbatim") "nil") " and a failure status. Autolith processes long prose in pieces. If any piece fails, you get no partial result. Inference runs locally. " (:em nil "Review the result") " before sharing it because model redaction does not guarantee anonymity.")

(:p nil "Packaged installations include the model and ONNX Runtime. For source installations without packaged defaults, set " (:code (:class "verbatim") "AUTOLITH_DEFINGERPRINTER_LIBRARY") " to the absolute native library path. Pass absolute paths for " (:code (:class "verbatim") ":model-directory") " and " (:code (:class "verbatim") ":runtime-library") ".")

(:h2 (:id "worker-tool-calls") "Worker tool calls")

(:p nil "Pass exact tool names in " (:code (:class "verbatim") "host-tools") " to " (:code (:class "verbatim") "lisp.eval") " or " (:code (:class "verbatim") "lisp.scratchpad-run") ". Inside the worker, call:")

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
    (:div (:class "sourceCode" :id "cb44" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb44-1") (:a (:href "#cb44-1" :aria-hidden "true" :tabindex "-1")) "(autolith:worker-tool-call " (:span (:class "st") "\"resource.read\"") " " (:span (:class "st") "\"{") (:span (:class "sc") "\\\"") (:span (:class "st") "uri") (:span (:class "sc") "\\\"") (:span (:class "st") ":") (:span (:class "sc") "\\\"") (:span (:class "st") "workspace:src/main.lisp") (:span (:class "sc") "\\\"") (:span (:class "st") "}\"") ")") "
" (:span (:id "cb44-2") (:a (:href "#cb44-2" :aria-hidden "true" :tabindex "-1")) "(autolith:worker-tool-context)"))))
    "
")
  "
")

(:p nil "Read " (:code (:class "verbatim") ":success-p") ", " (:code (:class "verbatim") ":content") ", " (:code (:class "verbatim") ":code") " and " (:code (:class "verbatim") ":details") " from the result. The originating conversation, permissions and mission admission apply to every callback. Use a different REPL for nested worker calls. Omit " (:code (:class "verbatim") "host-tools") " if no callbacks are needed.")

(:p nil "For example, pass these arguments to " (:code (:class "verbatim") "lisp.eval") " to return the content on success and the error code on failure:")

(:div (:class "window code-window")
  "
"
  (:div (:class "window-titlebar")
    "
JSON
")
  "
"
  (:div (:class "window-body")
    "
"
    (:div (:class "sourceCode" :id "cb45")
      (:pre (:class "sourceCode json") (:code (:class "sourceCode json") (:span (:id "cb45-1") (:a (:href "#cb45-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "fu") "{") (:span (:class "dt") "\"host-tools\"") (:span (:class "fu") ":") (:span (:class "ot") "[") (:span (:class "st") "\"resource.read\"") (:span (:class "ot") "]") (:span (:class "fu") ",")) "
" (:span (:id "cb45-2") (:a (:href "#cb45-2" :aria-hidden "true" :tabindex "-1")) " " (:span (:class "dt") "\"forms\"") (:span (:class "fu") ":") (:span (:class "ot") "[") (:span (:class "st") "\"(let ((result (autolith:worker-tool-call ") (:span (:class "ch") "\\\"") (:span (:class "st") "resource.read") (:span (:class "ch") "\\\"") (:span (:class "st") " ") (:span (:class "ch") "\\\"") (:span (:class "st") "{") (:span (:class "ch") "\\\\\\\"") (:span (:class "st") "uri") (:span (:class "ch") "\\\\\\\"") (:span (:class "st") ":") (:span (:class "ch") "\\\\\\\"") (:span (:class "st") "workspace:README.org") (:span (:class "ch") "\\\\\\\"") (:span (:class "st") "}") (:span (:class "ch") "\\\"") (:span (:class "st") "))) (if (getf result :success-p) (getf result :content) (getf result :code)))\"") (:span (:class "ot") "]") (:span (:class "fu") "}")))))
    "
")
  "
")

(:p nil "An interrupted callback is recorded as " (:code (:class "verbatim") "unknown-outcome") ". Inspect the effects before repeating a call that can change state.")

(:h2 (:id "structural-code-edits") "Structural code edits")

(:p nil "Load the optional system and configure " (:code (:class "verbatim") "ast-grep") " before creating the registry:")

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
    (:div (:class "sourceCode" :id "cb46" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb46-1") (:a (:href "#cb46-1" :aria-hidden "true" :tabindex "-1")) "(asdf:load-system " (:span (:class "st") "\"autolith/structural\"") ")") "
" (:span (:id "cb46-2") (:a (:href "#cb46-2" :aria-hidden "true" :tabindex "-1")) "(" (:span (:class "kw") "setf") " autolith:*structural-program* " (:span (:class "st") "\"/path/to/ast-grep\"") ")"))))
    "
")
  "
")

(:ol nil
  "
"
  (:li nil "Call " (:code (:class "verbatim") "structural.query") " with a workspace URI and revision you have read.")
  "
"
  (:li nil "Call " (:code (:class "verbatim") "structural.rewrite") " and inspect the preview.")
  "
"
  (:li nil "Publish with " (:code (:class "verbatim") "structural.apply") ". Proposals are single-use, owned by the conversation and subject to the same revision checks as resource edits.")
  "
")

(:p nil "For an existing registry, call " (:code (:class "verbatim") "structural-register-tools") " with " (:code (:class "verbatim") ":program") ". Ordinary executable and file authorization apply. To test the backend, set " (:code (:class "verbatim") "CLASTED_AST_GREP") " to the backend path and run " (:code (:class "verbatim") "(asdf:test-system \"autolith/structural/tests\")") ".")

(:h2 (:id "debug-adapter-sessions") "Debug adapter sessions")

(:p nil "Load " (:code (:class "verbatim") "autolith/debug") " before creating the registry. Configure an adapter in user initialization or pass it directly to " (:code (:class "verbatim") "debug.launch") " or " (:code (:class "verbatim") "debug.attach") ":")

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
    (:div (:class "sourceCode" :id "cb47" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb47-1") (:a (:href "#cb47-1" :aria-hidden "true" :tabindex "-1")) "(asdf:load-system " (:span (:class "st") "\"autolith/debug\"") ")") "
" (:span (:id "cb47-2") (:a (:href "#cb47-2" :aria-hidden "true" :tabindex "-1")) "(" (:span (:class "kw") "setf") " autolith:*debug-adapter-program* " (:span (:class "st") "\"/path/to/debug-adapter\"")) "
" (:span (:id "cb47-3") (:a (:href "#cb47-3" :aria-hidden "true" :tabindex "-1")) "      autolith:*debug-adapter-arguments* " (:span (:class "kw") "nil") ")"))))
    "
")
  "
")

(:p nil "For an existing registry, call " (:code (:class "verbatim") "debug-register-tools") " with " (:code (:class "verbatim") ":program") " and literal " (:code (:class "verbatim") ":arguments") ". Adapter execution, launch, attach and evaluation require exact full-access command approval. Authorize source and program paths as usual.")

(:p nil "Use the returned session ID in the conversation that created it:")

(:ul nil
  "
"
  (:li nil "Set breakpoints with " (:code (:class "verbatim") "debug.breakpoints") " and drive execution with " (:code (:class "verbatim") "debug.continue") ", " (:code (:class "verbatim") "debug.pause") " and " (:code (:class "verbatim") "debug.step") ".")
  "
"
  (:li nil "Inspect state with " (:code (:class "verbatim") "debug.threads") ", " (:code (:class "verbatim") "debug.stack") ", " (:code (:class "verbatim") "debug.scopes") ", " (:code (:class "verbatim") "debug.variables") " and " (:code (:class "verbatim") "debug.evaluate") ". Read queued events with " (:code (:class "verbatim") "debug.events") " and optionally pass " (:code (:class "verbatim") "count") " or " (:code (:class "verbatim") "wait-for") ".")
  "
"
  (:li nil "Interrupt an operation with " (:code (:class "verbatim") "debug.cancel") " or end the session with " (:code (:class "verbatim") "debug.terminate") ". On timeout or cancellation, Autolith closes the adapter.")
  "
")

(:p nil "Run the optional checks with " (:code (:class "verbatim") "(asdf:test-system \"autolith/debug/tests\")") ".")

(:h2 (:id "child-roles") "Child roles")

(:p nil "Autolith looks for roles in this order:")

(:ol nil
  "
"
  (:li nil (:code (:class "verbatim") ".autolith/agents/"))
  "
"
  (:li nil (:code (:class "verbatim") "${XDG_CONFIG_HOME:-~/.config}/autolith/agents/"))
  "
"
  (:li nil (:code (:class "verbatim") "<site-config-root>/agents/"))
  "
"
  (:li nil "Bundled roles.")
  "
")

(:p nil "The first match wins. If it is malformed, Autolith reports the error rather than looking for another copy. Define a role as one bounded UTF-8 " (:code (:class "verbatim") "*.sexp") " property list:")

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
    (:div (:class "sourceCode" :id "cb48" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb48-1") (:a (:href "#cb48-1" :aria-hidden "true" :tabindex "-1")) "(" (:span (:class "bu") ":name") "             " (:span (:class "st") "\"reviewer\"")) "
" (:span (:id "cb48-2") (:a (:href "#cb48-2" :aria-hidden "true" :tabindex "-1")) " :description      " (:span (:class "st") "\"Review a change for regressions.\"")) "
" (:span (:id "cb48-3") (:a (:href "#cb48-3" :aria-hidden "true" :tabindex "-1")) " :instructions     " (:span (:class "st") "\"Report concrete, evidence-backed findings.\"")) "
" (:span (:id "cb48-4") (:a (:href "#cb48-4" :aria-hidden "true" :tabindex "-1")) " :tools            (" (:span (:class "st") "\"resource.read\"") " " (:span (:class "st") "\"search.*\"") ")") "
" (:span (:id "cb48-5") (:a (:href "#cb48-5" :aria-hidden "true" :tabindex "-1")) " :spawns           " (:span (:class "kw") "nil")) "
" (:span (:id "cb48-6") (:a (:href "#cb48-6" :aria-hidden "true" :tabindex "-1")) " :models           (" (:span (:class "st") "\"@parent\"") ")") "
" (:span (:id "cb48-7") (:a (:href "#cb48-7" :aria-hidden "true" :tabindex "-1")) " :reasoning-effort :high)"))))
    "
")
  "
")

(:ul nil
  "
"
  (:li nil "Require " (:code (:class "verbatim") ":name") ", " (:code (:class "verbatim") ":description") " and " (:code (:class "verbatim") ":instructions") ". The other keys are optional.")
  "
"
  (:li nil "Use " (:code (:class "verbatim") "nil") ", " (:code (:class "verbatim") ":all") " or exact names and namespace patterns for " (:code (:class "verbatim") ":tools") ". A role cannot grant " (:code (:class "verbatim") "self.*") ", " (:code (:class "verbatim") "task.*") " or " (:code (:class "verbatim") "yield.*") ". Grant " (:code (:class "verbatim") "job.*") " for job inspection, waiting or cancellation. Children can only access their own jobs and those of their descendants.")
  "
"
  (:li nil "Use " (:code (:class "verbatim") "nil") ", " (:code (:class "verbatim") ":all") " or a list of role names for " (:code (:class "verbatim") ":spawns") ". The task depth limit still applies.")
  "
"
  (:li nil "Set " (:code (:class "verbatim") ":reasoning-effort") " to a supported effort. Omit it or use " (:code (:class "verbatim") ":auto") " for " (:code (:class "verbatim") "medium") ". Codex Fast mode is not inherited.")
  "
")

(:p nil "Use " (:code (:class "verbatim") "child.roles") " to see effective roles and " (:code (:class "verbatim") "child.spawn") " to start a task. Reuse a child by sending work to its channel. An agent can have up to 32 children. Read " (:code (:class "verbatim") "channel:current") " to see which are busy. Use " (:code (:class "verbatim") "child.rename") " to rename one, " (:code (:class "verbatim") "child.compact") " to summarize an idle child's history, or " (:code (:class "verbatim") "child.remove") " to delete an idle child and its descendants. Opening a child's channel uses the same role and tools as a delegated run.")

(:p nil "Channel deletion validates the whole selection first. If storage cleanup fails after deletion, use the " (:code (:class "verbatim") "retry-cleanup") " restart or let the next server start or deletion retry the intent in " (:code (:class "verbatim") "channel-removals/") ". Deleted identities cannot be reopened from leftover history.")

(:h2 (:id "completion-driven-turns") "Completion-driven turns")

(:p nil "Set " (:code (:class "verbatim") "completion-policy") " on asynchronous tools or " (:code (:class "verbatim") "child.spawn") ". The same policy applies if a synchronous call outlasts the blocking grace period. Batch items inherit the outer policy unless they specify their own.")

(:ul nil
  "
"
  (:li nil (:code (:class "verbatim") "continue") " is the default. In a primary terminal or ACP session, idle completions in a one-second window share one automatic turn. If a turn is busy, results arrive at the next safe request boundary.")
  "
"
  (:li nil "With " (:code (:class "verbatim") "notify") ", results arrive on the next ordinary turn. Interfaces without an input controller also deliver results on ordinary turns.")
  "
")

(:p nil "Continue independent work while jobs run. Yield the turn if all you need is the results. An empty reply shows a yield notice that counts the unfinished jobs eligible to wake the conversation. Use " (:code (:class "verbatim") "job.get") " to inspect a result or " (:code (:class "verbatim") "job.wait") " if you need to wait explicitly.")

(:p nil "A goal or mission waits for eligible job results before resuming automatic continuations. Only the conversation that owns the work gets a wakeup. Delivery receipts survive restart and compaction, so a notification can be restored without repeating the job. Cancellation, paused or terminal missions, and spent budgets can prevent automatic turns.")

(:h2 (:id "task-inspection-and-continuity") "Task inspection and continuity")

(:p nil "Use " (:code (:class "verbatim") "(tell \"CHILD\" \"text\")") " to steer a running child at its next safe boundary. Use " (:code (:class "verbatim") "job.continuity") " with " (:code (:class "verbatim") "action") " set to " (:code (:class "verbatim") "list") " or " (:code (:class "verbatim") "get") " to see which retained jobs are live, complete, recoverable or need a decision. Lists default to 20 records (maximum 100). Pass " (:code (:class "verbatim") "offset") " to page and read " (:code (:class "verbatim") ":total") ", " (:code (:class "verbatim") ":next-offset") " and " (:code (:class "verbatim") ":more-p") " from the result.")

(:p nil "To recover interrupted work:")

(:ol nil
  "
"
  (:li nil "Inspect the retained job and its effects. Use a visible job ID or durable execution ID in " (:code (:class "verbatim") "id") ".")
  "
"
  (:li nil "To permit a restart, the primary owner calls " (:code (:class "verbatim") "allow-restart") " with a " (:code (:class "verbatim") "safety") " rationale about repeating external effects and " (:code (:class "verbatim") "authorize: true") ". For a saved worker, use " (:code (:class "verbatim") "checkpoint") " with a compatible " (:code (:class "verbatim") "image") ", target " (:code (:class "verbatim") "repl") " and " (:code (:class "verbatim") "authorize: true") ".")
  "
"
  (:li nil "Use " (:code (:class "verbatim") "revive") " or " (:code (:class "verbatim") "abandon") " with the ID and " (:code (:class "verbatim") "authorize: true") ". Revival can reattach live work, start the saved worker or dispatch a new child from a retained safe shared-workspace task specification.")
  "
")

(:p nil "Autolith records the decision before dispatch and links the executions. If revival fails or is interrupted, inspect the uncertain outcome before trying again. Resuming a conversation shows the inventory without replaying work.")

(:h2 (:id "isolated-modifying-tasks") "Isolated modifying tasks")

(:p nil "Pass an " (:code (:class "verbatim") "isolation") " object to " (:code (:class "verbatim") "child.spawn") " to give the child a detached Git checkout. Omit it for a shared workspace. Use these fields:")

(:ul nil
  "
"
  (:li nil (:code (:class "verbatim") "baseline") " resolves to a commit. The default is " (:code (:class "verbatim") "HEAD") ".")
  "
"
  (:li nil (:code (:class "verbatim") "dirtyPolicy") " defaults to " (:code (:class "verbatim") "reject") ". Use " (:code (:class "verbatim") "ignore") " to start from the committed baseline and exclude staged, unstaged and untracked source changes.")
  "
"
  (:li nil (:code (:class "verbatim") "artifactKind") " defaults to " (:code (:class "verbatim") "patch") ". A patch includes committed and uncommitted tracked changes. Use " (:code (:class "verbatim") "commit-range") " for a clean checkout whose history descends from the baseline.")
  "
")

(:p nil (:strong nil "Stage new files") " before yielding. The terminal result identifies the artifact for integration, including on abort. If extraction fails, Autolith retains the checkout and reports " (:code (:class "verbatim") ":worktree-error") ".")

(:p nil "Use " (:code (:class "verbatim") "child.worktree") " with an explicit " (:code (:class "verbatim") "action") ":")

(:ul nil
  "
"
  (:li nil (:code (:class "verbatim") "inspect") " reports provenance, touched paths and the artifact path. Use " (:code (:class "verbatim") "extract") " to retry extraction after repairing a checkout. Pass the terminal job or durable execution ID as " (:code (:class "verbatim") "id") ".")
  "
"
  (:li nil (:code (:class "verbatim") "check") " checks patch applicability. Use " (:code (:class "verbatim") "apply") " to patch the clean target or " (:code (:class "verbatim") "commits") " to cherry-pick the range. Pass " (:code (:class "verbatim") "id") " and an explicit " (:code (:class "verbatim") "target") ".")
  "
"
  (:li nil (:code (:class "verbatim") "conflicts") " shows unmerged paths. Use " (:code (:class "verbatim") "abort") " to abort an interrupted cherry-pick. Pass the target repository.")
  "
"
  (:li nil (:code (:class "verbatim") "cleanup") " removes the owned checkout. Pass " (:code (:class "verbatim") "discardDirty: true") " to discard local changes. The secured artifact is separate from the checkout.")
  "
"
  (:li nil (:code (:class "verbatim") "discover") " lists owned worktrees. Pass " (:code (:class "verbatim") "source") " to recover registration from Git markers. Use " (:code (:class "verbatim") "cleanup-orphan") " with the discovered worktree " (:code (:class "verbatim") "id") " and " (:code (:class "verbatim") "source") " to clean up after failed task publication.")
  "
")

(:p nil "The sandbox can write the isolated checkout and its Git administrative directories. Integration requires authorization for the target. Worktree isolation prevents accidental overlap. It does not confine hostile code.")

(:p nil "The default pool admits eight concurrent children. Set " (:code (:class "verbatim") "AUTOLITH_TASK_MAX_CONCURRENCY") " to raise this up to 32. Set " (:code (:class "verbatim") "AUTOLITH_TASK_MAX_DEPTH") " to change the default depth of three below a primary agent. Child jobs have a one-hour wall-clock deadline by default. Set " (:code (:class "verbatim") "AUTOLITH_TASK_MAX_RUNTIME_MS") " to change it in milliseconds or use zero to disable it.")

(:h2 (:id "reusable-shell-sessions") "Reusable shell sessions")

(:p nil "Pass " (:code (:class "verbatim") "session") " to " (:code (:class "verbatim") "shell.run") " to reuse a POSIX shell. Commands in one shell run serially and share variables, functions and the current directory. Pass " (:code (:class "verbatim") "directory") " to change the directory first. Autolith authorizes each command in its observed directory and captures separate logs for each invocation. Use " (:code (:class "verbatim") "description") " to label the live row.")

(:ul nil
  "
"
  (:li nil "Use " (:code (:class "verbatim") "shell.sessions") " to inspect live and dead shells.")
  "
"
  (:li nil "Use " (:code (:class "verbatim") "shell.close") " to stop and forget a shell.")
  "
"
  (:li nil "Use " (:code (:class "verbatim") "shell.reset") " to replace a shell after exit, timeout or cancellation, or after permissions, workspace or writable scopes change.")
  "
")

(:p nil "The runtime stops its shells and descendants on shutdown. Reset does not replay commands. Keep temporary storage outside writable workspace roots for sandboxed sessions. On Windows, or for an independent POSIX command, omit " (:code (:class "verbatim") "session") ". Use native PowerShell on Windows.")

(:p nil "On Windows, add existing read-only tool directories with " (:code (:class "verbatim") "*win32-sandbox-read-roots*") ". Sandboxed commands run serially while the helper applies temporary access rules. Use local directories without reparse points or hard-linked files. Unsupported scopes or a missing helper cause the command to fail.")

(:h2 (:id "retained-command-output") "Retained command output")

(:p nil (:code (:class "verbatim") "shell.run") " returns the exit status and capture details with a short preview. Pass " (:code (:class "verbatim") "separate-output: true") " to capture stdout and stderr separately. Read the " (:code (:class "verbatim") "shell-log:") " references from the result or from job inspection after a restart or compaction. You do not need to rerun the command.")

(:p nil "Use " (:code (:class "verbatim") "resource.read") " with zero-based " (:code (:class "verbatim") "byte-offset") " and " (:code (:class "verbatim") "byte-count") " (default and maximum 4096 bytes). For a literal search, use " (:code (:class "verbatim") "query") " and optionally " (:code (:class "verbatim") "max-results") ". Continue at the returned offset. A search scans up to 1 MiB per page. The default is 20 excerpts and the maximum is 50. Text display replaces invalid UTF-8. The retained capture preserves the original bytes.")

(:p nil "Share the exact reference with another agent to give it access to range reads and searches, including across tasks or sessions.")

(:p nil "The defaults are 64 MiB per stream and 1 GiB overall. If a stream exceeds its limit, the result marks the capture incomplete. Eligible captures can be pruned after seven days or if the overall limit is reached. Live captures, pending results and captures that support active structured facts receive pruning protection.")

(:p nil "Adjust " (:code (:class "verbatim") "*shell-log-capture-byte-limit*") ", " (:code (:class "verbatim") "*shell-log-retention-byte-limit*") " and " (:code (:class "verbatim") "*shell-log-retention-age*") " in trusted configuration. Session export collects task metadata independently of local log storage.")
