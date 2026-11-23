(:h1 (:id "configure-autolith") "Configure Autolith")

(:h2 (:id "settings") "Change a setting")

(:ol nil (:li nil "Run " (:code nil "(settings)") " to open the settings picker.")
 (:li nil "Select a setting to see the current value, where it was set and the available choices.")
 (:li nil "Choose a value. Autolith saves durable settings in " (:code nil "preferences.sexp")
  ". Session settings last until you exit."))

(:p nil "At the prompt, " (:code nil "(settings :boot-screen-seconds)") " shows the setting and "
 (:code nil "(settings :boot-screen-seconds 2)") " changes it. Pass " (:code nil "nil")
 " explicitly to turn off a switch.")

(:p nil
 "For durable settings, Autolith checks these sources in order and uses the first value it finds:")

(:ol nil (:li nil "A command-line option.") (:li nil "The environment variable for the setting.")
 (:li nil "The saved preference."))

(:h2 (:id "configuration-files") "Find your configuration files")

(:p nil "Put personal configuration in "
 (:code nil "${XDG_CONFIG_HOME:-~/.config}/autolith/init.lisp")
 ". Autolith evaluates the file in the " (:code nil "AUTOLITH")
 " package with your privileges. Start with " (:code nil "--pristine")
 " to skip executable initialization and private replay.")

(:p nil "Autolith loads configuration in this order:")

(:ol nil
 (:li nil "The site " (:code nil "init.lisp") ", if you set a site root with "
  (:code nil "--site-config-root DIRECTORY") " or " (:code nil "AUTOLITH_SITE_CONFIG_ROOT")
  ". Use an existing absolute directory.")
 (:li nil "Trusted " (:code nil ".autolith/init.lisp")
  " files, from the outermost directory to the nearest one.")
 (:li nil "Your personal " (:code nil "init.lisp") "."))

(:h2 (:id "configuration-topics") "Configure a feature")

(:ul nil
 (:li (:id "providers")
  (:div nil (:a (:href "/autolith/docs/models-and-providers") "Models and providers"))
  (:ul nil
   (:li (:id "model-catalogs-and-sign-in")
    (:div nil
     (:a (:href "/autolith/docs/models-and-providers#model-catalogs-and-sign-in")
      "Sign in and choose a model")))
   (:li (:id "add-another-openai-compatible-provider")
    (:div nil
     (:a (:href "/autolith/docs/models-and-providers#add-another-openai-compatible-provider")
      "Add a provider")))))
 (:li (:id "run-a-local-model")
  (:div nil (:a (:href "/autolith/docs/run-a-local-model") "Run a local model with Ollama")))
 (:li (:id "context") (:div nil (:a (:href "/autolith/docs/manage-context") "Manage context"))
  (:ul nil
   (:li (:id "compaction")
    (:div nil (:a (:href "/autolith/docs/manage-context#compaction") "Compact a conversation")))
   (:li (:id "output-limits-and-admission")
    (:div nil
     (:a (:href "/autolith/docs/manage-context#output-limits-and-admission") "Set token limits")))))
 (:li (:id "language-servers")
  (:div nil (:a (:href "/autolith/docs/connect-development-tools") "Connect development tools"))
  (:ul nil
   (:li (:id "structural-code-edits")
    (:div nil
     (:a (:href "/autolith/docs/connect-development-tools#structural-code-edits")
      "Make structural edits")))
   (:li (:id "debug-adapter-sessions")
    (:div nil
     (:a (:href "/autolith/docs/connect-development-tools#debug-adapter-sessions")
      "Connect a debugger")))
   (:li nil
    (:div nil
     (:a (:href "/autolith/docs/connect-development-tools#connect-mcp") "Connect an MCP server")))))
 (:li (:id "commands")
  (:div nil (:a (:href "/autolith/docs/customise-autolith") "Customise commands, skills and Lisp"))
  (:ul nil
   (:li (:id "executable-skills")
    (:div nil (:a (:href "/autolith/docs/customise-autolith#executable-skills") "Load a skill")))
   (:li (:id "live-definitions")
    (:div nil
     (:a (:href "/autolith/docs/customise-autolith#live-definitions") "Change a live definition")))
   (:li (:id "active-image-management-endpoint")
    (:div nil
     (:a (:href "/autolith/docs/customise-autolith#active-image-management-endpoint")
      "Connect to the running Lisp image")))))
 (:li (:id "child-roles")
  (:div nil (:a (:href "/autolith/docs/manage-tasks") "Manage delegated tasks and jobs"))))
