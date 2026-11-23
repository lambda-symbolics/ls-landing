(:h1 (:id "connect-development-tools") "Connect development tools")

(:h2 (:id "language-servers") "Set up a language server")

(:ol nil (:li nil "Install a language server that you trust. Autolith runs it with your privileges.")
 (:li nil
  (:p nil "Create " (:code nil "lsp.sexp") " beside " (:code nil "init.lisp")
   ". For C and C++, you can start with this example for clangd:")
  (:div (:class "window code-window") "
"
   (:div (:class "window-titlebar") "
Common Lisp
")
   "
"
   (:div (:class "window-body") "
"
    (:div (:class "sourceCode" :id "cb22" :data-org-language "lisp")
     (:pre (:class "sourceCode commonlisp")
      (:code (:class "sourceCode commonlisp")
       (:span (:id "cb22-1") (:a (:href "#cb22-1" :aria-hidden "true" :tabindex "-1")) "("
        (:span (:class "bu") ":version") " " (:span (:class "dv") "1"))
       "
"
       (:span (:id "cb22-2") (:a (:href "#cb22-2" :aria-hidden "true" :tabindex "-1")) " :servers (("
        (:span (:class "bu") ":name") " " (:span (:class "st") "\"clangd\""))
       "
"
       (:span (:id "cb22-3") (:a (:href "#cb22-3" :aria-hidden "true" :tabindex "-1"))
        "            :command " (:span (:class "st") "\"clangd\""))
       "
"
       (:span (:id "cb22-4") (:a (:href "#cb22-4" :aria-hidden "true" :tabindex "-1"))
        "            :arguments (" (:span (:class "st") "\"--background-index\"") ")")
       "
"
       (:span (:id "cb22-5") (:a (:href "#cb22-5" :aria-hidden "true" :tabindex "-1"))
        "            :extensions (" (:span (:class "st") "\".c\"") " " (:span (:class "st") "\".h\"")
        ")")
       "
"
       (:span (:id "cb22-6") (:a (:href "#cb22-6" :aria-hidden "true" :tabindex "-1"))
        "            :language-id " (:span (:class "st") "\"c\""))
       "
"
       (:span (:id "cb22-7") (:a (:href "#cb22-7" :aria-hidden "true" :tabindex "-1"))
        "            :root-markers (" (:span (:class "st") "\"compile_commands.json\"") " "
        (:span (:class "st") "\".git\"") ")")
       "
"
       (:span (:id "cb22-8") (:a (:href "#cb22-8" :aria-hidden "true" :tabindex "-1"))
        "            :timeout-seconds " (:span (:class "dv") "30") ")))"))))
    "
")
   "
"))
 (:li nil "Ask Autolith to run " (:code nil "lsp.status")
  " to check the configuration. After editing the file, use " (:code nil "lsp.restart")
  " to reload it."))

(:ul nil (:li nil "Use " (:code nil "lsp.query") " to find definitions or references.")
 (:li nil "Use " (:code nil "lsp.diagnostics") " to check a file for errors.")
 (:li nil "Ask Autolith to propose a rename or code action with " (:code nil "lsp.semantic")
  ". Review the proposal before applying it. If the file changes, request a new proposal."))

(:h2 (:id "structural-code-edits") "Make structural edits")

(:p nil "Install ast-grep and put this in " (:code nil "init.lisp")
 " with the path to the executable:")

(:div (:class "window code-window") "
"
 (:div (:class "window-titlebar") "
Common Lisp
")
 "
"
 (:div (:class "window-body") "
"
  (:div (:class "sourceCode" :id "cb46" :data-org-language "lisp")
   (:pre (:class "sourceCode commonlisp")
    (:code (:class "sourceCode commonlisp")
     (:span (:id "cb46-1") (:a (:href "#cb46-1" :aria-hidden "true" :tabindex "-1"))
      "(asdf:load-system " (:span (:class "st") "\"autolith/structural\"") ")")
     "
"
     (:span (:id "cb46-2") (:a (:href "#cb46-2" :aria-hidden "true" :tabindex "-1")) "("
      (:span (:class "kw") "setf") " autolith:*structural-program* "
      (:span (:class "st") "\"/path/to/ast-grep\"") ")"))))
  "
")
 "
")

(:ol nil (:li nil "Ask Autolith to find matching code with " (:code nil "structural.query") ".")
 (:li nil "Review the preview from " (:code nil "structural.rewrite") ".")
 (:li nil "Apply the proposed change with " (:code nil "structural.apply") "."))

(:h2 (:id "debug-adapter-sessions") "Connect a debugger")

(:p nil "Install a debug adapter for the language you use. Add the following to "
 (:code nil "init.lisp") " and set the path to the adapter:")

(:div (:class "window code-window") "
"
 (:div (:class "window-titlebar") "
Common Lisp
")
 "
"
 (:div (:class "window-body") "
"
  (:div (:class "sourceCode" :id "cb47" :data-org-language "lisp")
   (:pre (:class "sourceCode commonlisp")
    (:code (:class "sourceCode commonlisp")
     (:span (:id "cb47-1") (:a (:href "#cb47-1" :aria-hidden "true" :tabindex "-1"))
      "(asdf:load-system " (:span (:class "st") "\"autolith/debug\"") ")")
     "
"
     (:span (:id "cb47-2") (:a (:href "#cb47-2" :aria-hidden "true" :tabindex "-1")) "("
      (:span (:class "kw") "setf") " autolith:*debug-adapter-program* "
      (:span (:class "st") "\"/path/to/debug-adapter\""))
     "
"
     (:span (:id "cb47-3") (:a (:href "#cb47-3" :aria-hidden "true" :tabindex "-1"))
      "      autolith:*debug-adapter-arguments* " (:span (:class "kw") "nil") ")"))))
  "
")
 "
")

(:ol nil
 (:li nil "Ask Autolith to launch the program with " (:code nil "debug.launch")
  " or attach to a running process with " (:code nil "debug.attach")
  ". Approve the debugger command if you trust it.")
 (:li nil "Set breakpoints with " (:code nil "debug.breakpoints") ". Use "
  (:code nil "debug.continue") " to run to a breakpoint or " (:code nil "debug.step")
  " to step through code.")
 (:li nil "Inspect the stack with " (:code nil "debug.stack") " or values with "
  (:code nil "debug.variables") ".")
 (:li nil "End the debug session with " (:code nil "debug.terminate") "."))

(:h2 (:id "connect-mcp") "Connect an MCP server")

(:ol nil
 (:li nil "Create " (:code nil "mcp.sexp") " beside " (:code nil "init.lisp") ". Follow the "
  (:a (:href "https://github.com/lambda-symbolics/autolith/blob/v0.67.66/docs/mcp.org")
   "MCP setup examples")
  " for your transport.")
 (:li nil "Run " (:code nil "(mcp :refresh)") " after editing the file. Use " (:code nil "(mcp)")
  " to inspect the connection."))
