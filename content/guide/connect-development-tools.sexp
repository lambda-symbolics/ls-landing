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
 (:li nil "Ask Autolith to check that the language server is running. After editing the configuration, ask Autolith to restart the server."))

(:p nil "Try asking where a function is defined, where it is used, or why the language server reports an error in a file. If you ask for a rename, review the proposed edits before approving them.")

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

(:ol nil (:li nil "Ask Autolith to find calls to a function or another pattern in your code.")
 (:li nil "Describe the change and ask to see a preview of the edits.")
 (:li nil "Review the preview before you ask Autolith to apply the edits."))

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
 (:li nil "Ask Autolith to launch the program under the debugger or attach to a running process. Approve the debugger command if you trust it.")
 (:li nil "Ask Autolith to set a breakpoint at a line or function, then run to the breakpoint.")
 (:li nil "Ask to see the call stack or the value of a variable before you step through the code.")
 (:li nil "Ask Autolith to end the debug session when you are done."))

(:h2 (:id "connect-mcp") "Connect an MCP server")

(:ol nil
 (:li nil "Create " (:code nil "mcp.sexp") " beside " (:code nil "init.lisp") ". Follow the "
  (:a (:href "https://github.com/lambda-symbolics/autolith/blob/v0.67.66/docs/mcp.org")
   "MCP setup examples")
  " for your transport.")
 (:li nil "Run " (:code nil "(mcp :refresh)") " after editing the file. Use " (:code nil "(mcp)")
  " to inspect the connection."))
