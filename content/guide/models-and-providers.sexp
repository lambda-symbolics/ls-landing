(:h1 (:id "models-and-providers") "Models and providers")

(:h2 (:id "model-catalogs-and-sign-in") "Sign in and choose a model")

(:ol nil
 (:li nil "Run " (:code nil "autolith auth PROVIDER") ". Replace " (:code nil "PROVIDER")
  " with the provider name. In a session, use " (:code nil "(auth \"PROVIDER\")") ".")
 (:li nil "Follow the sign-in prompt. For an API provider, paste your key at the hidden prompt.")
 (:li nil "Run " (:code nil "(models)") " to refresh the list, then " (:code nil "(model)")
  " to choose a model."))

(:ul nil
 (:li nil (:strong nil (:code nil "chatgpt")) " uses your ChatGPT subscription. Use "
  (:code nil "autolith auth chatgpt device") " if you need a device code.")
 (:li nil (:strong nil (:code nil "openai-api")) " uses an OpenAI API key.")
 (:li nil (:strong nil (:code nil "copilot")) " uses your GitHub Copilot subscription. Pick "
  (:code nil "copilot/auto")
  " on Student or Free plans. For GitHub Enterprise Cloud with data residency, set "
  (:code nil "AUTOLITH_COPILOT_DOMAIN") " to your " (:code nil "TENANT.ghe.com")
  " hostname before sign-in and subsequent launches.")
 (:li nil "For OpenCode, use " (:strong nil (:code nil "opencode-go")) " or "
  (:strong nil (:code nil "opencode-zen")) " according to your plan.")
 (:li nil "Use " (:strong nil (:code nil "gemini"))
  " for the Gemini subscription. For Google Vertex AI, sign in with "
  (:code nil "gcloud auth application-default login") ", set "
  (:code nil "GOOGLE_CLOUD_PROJECT") " and " (:code nil "GOOGLE_CLOUD_LOCATION")
  ", then choose a model from " (:strong nil (:code nil "vertex-gemini")) " or "
  (:strong nil (:code nil "vertex-anthropic")) "."))

(:p nil "Use " (:code nil "autolith models") " to list locally known models. Use "
 (:code nil "(model \"PROVIDER/MODEL\")") " to save a choice or "
 (:code nil "autolith --model PROVIDER/MODEL")
 " to choose a model for one launch. To pass an exact catalog ID, use "
 (:code nil "--provider PROVIDER --model MODEL") ".")

(:p nil "If you use ChatGPT and want faster replies, try "
 (:code nil "(settings :codex-fast-mode-p t)")
 ". Fast mode is available for supported models and counts more heavily against plan usage.")

(:h2 (:id "add-another-openai-compatible-provider") "Add another OpenAI-compatible provider")

(:p nil "Use " (:code nil "register-openai-compatible-provider") " in " (:code nil "init.lisp")
 " for services that support streaming Chat Completions. Adapt "
 (:a (:href "/autolith/docs/run-a-local-model") "the Ollama example") ":")

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
