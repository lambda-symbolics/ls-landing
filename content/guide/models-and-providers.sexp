(:h1 (:id "models-and-providers") "Models and providers")

(:h2 (:id "model-catalogs-and-sign-in") "Sign in and choose a model")

(:ol nil
 (:li nil "Run " (:code nil "autolith auth PROVIDER") ". Replace " (:code nil "PROVIDER")
  " with the provider name. In a session, use " (:code nil "(auth \"PROVIDER\")") ".")
 (:li nil "Follow the sign-in prompt. For an API provider, paste your key at the hidden prompt.")
 (:li nil "Run " (:code nil "(models)") " to refresh the list, then " (:code nil "(model)")
  " to choose a model."))

(:ul nil
 (:li nil (:code nil "chatgpt") " uses your ChatGPT subscription. Use "
  (:code nil "autolith auth chatgpt device") " if you need a device code.")
 (:li nil (:code nil "openai-api") " uses an OpenAI API key.")
 (:li nil (:code nil "copilot") " uses your GitHub Copilot subscription. Pick "
  (:code nil "copilot/auto")
  " on Student or Free plans. For GitHub Enterprise Cloud with data residency, set "
  (:code nil "AUTOLITH_COPILOT_DOMAIN") " to your " (:code nil "TENANT.ghe.com")
  " hostname before sign-in and subsequent launches.")
 (:li nil "For OpenCode, use " (:code nil "opencode-go") " or " (:code nil "opencode-zen")
  " according to your plan.")
 (:li nil "Use " (:code nil "gemini")
  " for the Gemini subscription. For Google Vertex AI, sign in with "
  (:code nil "gcloud auth application-default login") ", set " (:code nil "GOOGLE_CLOUD_PROJECT")
  " and " (:code nil "GOOGLE_CLOUD_LOCATION") ", then choose a model from "
  (:code nil "vertex-gemini") " or " (:code nil "vertex-anthropic") "."))

(:p nil "Use " (:code nil "autolith models") " to list locally known models. Use "
 (:code nil "(model \"PROVIDER/MODEL\")") " to save a choice or "
 (:code nil "autolith --model PROVIDER/MODEL")
 " to choose a model for one launch. To pass an exact catalog ID, use "
 (:code nil "--provider PROVIDER --model MODEL") ".")

(:p nil "If you use ChatGPT and want faster replies, try "
 (:code nil "(settings :codex-fast-mode-p t)")
 ". Fast mode is available for supported models and counts more heavily against plan usage.")

(:h2 (:id "run-a-local-model") "Run a local model with Ollama")

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

(:h3 (:id "ollama-troubleshooting") "Troubleshoot Ollama")

(:ul nil
 (:li nil (:strong nil "Unknown model.") " Run " (:code nil "ollama list")
  " and copy the exact ID into " (:code nil ":models") ".")
 (:li nil (:strong nil "Rejected stream options.") " Set " (:code nil ":stream-usage-p nil")
  " as shown above.")
 (:li nil (:strong nil "Context limit is too small.")
  " Raise the limit on the server first. Then set " (:code nil ":models") " to a list such as "
  (:code nil "'((:name \"qwen3:8b\" :context-window 32768))")
  ", using the limit you set on the server."))

(:h2 (:id "add-another-openai-compatible-provider") "Add another OpenAI-compatible provider")

(:p nil "Use " (:code nil "register-openai-compatible-provider") " in " (:code nil "init.lisp")
 " for services that support streaming Chat Completions. Adapt the Ollama example:")

(:ol nil
 (:li nil "Choose a unique " (:code nil ":name") " and set " (:code nil ":endpoint")
  " to the full Chat Completions URL.")
 (:li nil "List model IDs in " (:code nil ":models") ", set " (:code nil ":models-endpoint")
  " to the full model list URL, or set both. List an ID explicitly if you want to select it on the first launch.")
 (:li nil "Restart Autolith. Set the environment variable you named in "
  (:code nil ":api-key-environment-variable") " or save a key with "
  (:code nil "autolith auth PROVIDER") ". If both are set, Autolith uses the environment variable.")
 (:li nil "Run " (:code nil "(models :provider \"PROVIDER\")")
  " to refresh the catalog. Select a model with " (:code nil "(model \"PROVIDER/MODEL\")") "."))
