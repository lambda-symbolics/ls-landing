(:h1 (:id "run-a-local-model") "Run a local model with Ollama")

(:p nil "Use a model that supports tool calls if you want Autolith to read files or run commands.")

(:ol nil
 (:li nil
  (:p nil "Start " (:code nil "ollama serve")
   " if Ollama is not running. Download the model in another terminal:")
  (:div (:class "window code-window") "
"
   (:div (:class "window-titlebar") "
Shell
")
   "
"
   (:div (:class "window-body") "
"
    (:div (:class "sourceCode" :id "cb31" :data-org-language "sh")
     (:pre (:class "sourceCode bash")
      (:code (:class "sourceCode bash")
       (:span (:id "cb31-1") (:a (:href "#cb31-1" :aria-hidden "true" :tabindex "-1"))
        (:span (:class "ex") "ollama") " pull qwen3:8b"))))
    "
")
   "
"))
 (:li nil
  (:p nil "Add this form to " (:code nil "${XDG_CONFIG_HOME:-~/.config}/autolith/init.lisp") ":")
  (:div (:class "window code-window") "
"
   (:div (:class "window-titlebar") "
Common Lisp
")
   "
"
   (:div (:class "window-body") "
"
    (:div (:class "sourceCode" :id "cb32" :data-org-language "lisp")
     (:pre (:class "sourceCode commonlisp")
      (:code (:class "sourceCode commonlisp")
       (:span (:id "cb32-1") (:a (:href "#cb32-1" :aria-hidden "true" :tabindex "-1"))
        "(register-openai-compatible-provider")
       "
"
       (:span (:id "cb32-2") (:a (:href "#cb32-2" :aria-hidden "true" :tabindex "-1")) " "
        (:span (:class "bu") ":name") "                         "
        (:span (:class "st") "\"local-ollama\""))
       "
"
       (:span (:id "cb32-3") (:a (:href "#cb32-3" :aria-hidden "true" :tabindex "-1"))
        " :endpoint                     "
        (:span (:class "st") "\"http://127.0.0.1:11434/v1/chat/completions\""))
       "
"
       (:span (:id "cb32-4") (:a (:href "#cb32-4" :aria-hidden "true" :tabindex "-1"))
        " :models                       '(" (:span (:class "st") "\"qwen3:8b\"") ")")
       "
"
       (:span (:id "cb32-5") (:a (:href "#cb32-5" :aria-hidden "true" :tabindex "-1"))
        " :api-key-environment-variable " (:span (:class "st") "\"AUTOLITH_OLLAMA_KEY\""))
       "
"
       (:span (:id "cb32-6") (:a (:href "#cb32-6" :aria-hidden "true" :tabindex "-1"))
        " :stream-usage-p               " (:span (:class "kw") "nil") ")"))))
    "
")
   "
"))
 (:li nil
  (:p nil "Set a nonempty key and start Autolith. Local Ollama ignores the key, so you can use "
   (:code nil "ollama") " as the value.")
  (:div (:class "window code-window") "
"
   (:div (:class "window-titlebar") "
Shell
")
   "
"
   (:div (:class "window-body") "
"
    (:div (:class "sourceCode" :id "cb33" :data-org-language "sh")
     (:pre (:class "sourceCode bash")
      (:code (:class "sourceCode bash")
       (:span (:id "cb33-1") (:a (:href "#cb33-1" :aria-hidden "true" :tabindex "-1"))
        (:span (:class "bu") "export") " " (:span (:class "va") "AUTOLITH_OLLAMA_KEY")
        (:span (:class "op") "=") "ollama")
       "
"
       (:span (:id "cb33-2") (:a (:href "#cb33-2" :aria-hidden "true" :tabindex "-1"))
        (:span (:class "ex") "autolith") " models " (:span (:class "kw") "|") " "
        (:span (:class "fu") "grep") " " (:span (:class "at") "-Fx") " "
        (:span (:class "st") "'local-ollama/qwen3:8b'"))
       "
"
       (:span (:id "cb33-3") (:a (:href "#cb33-3" :aria-hidden "true" :tabindex "-1"))
        (:span (:class "ex") "autolith") " " (:span (:class "at") "--provider") " local-ollama "
        (:span (:class "at") "--model") " qwen3:8b"))))
    "
")
   "
"))
 (:li nil
  "Send a short prompt to check that the reply streams. Ask Autolith to list the files in the current directory to check tool calls."))

(:h2 (:id "ollama-troubleshooting") "Troubleshoot Ollama")

(:ul nil
 (:li nil (:strong nil "Unknown model.") " Run " (:code nil "ollama list")
  " and copy the exact ID into " (:code nil ":models") ".")
 (:li nil (:strong nil "Rejected stream options.") " Set " (:code nil ":stream-usage-p nil")
  " as shown above.")
 (:li nil (:strong nil "Context limit is too small.")
  " Raise the limit on the server first. Then set " (:code nil ":models") " to a list such as "
  (:code nil "'((:name \"qwen3:8b\" :context-window 32768))")
  ", using the limit you set on the server."))
