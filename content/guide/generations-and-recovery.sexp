(:h1 (:id "generations-and-recovery") "Generations and recovery")

(:h2 (:id "save-a-generation") "Save a generation")

(:p nil "Use " (:code nil "(checkpoint)")
 " to save the running image as a retained generation. The source checkout must be clean and pass the project checks. Use "
 (:code nil "(checkpoint :allow-dirty t)") " to include uncommitted source changes.")

(:p nil "A checkpoint can wait for active work in other channels. Use "
 (:code nil "(checkpoint-cancel)") " to cancel a waiting checkpoint.")

(:h2 (:id "restore-a-generation") "Restore a generation")

(:p nil "Run " (:code nil "(generations)") " to find a retained image. Use "
 (:code nil "(rollback \"GENERATION-ID\")") " to select it for startup, or launch it from the shell:")

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
    (:div (:class "sourceCode" :id "cb63" :data-org-language "sh")
      (:pre (:class "sourceCode bash") (:code (:class "sourceCode bash") (:span (:id "cb63-1") (:a (:href "#cb63-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " " (:span (:class "at") "--recovery") " " (:span (:class "at") "--list")) "
" (:span (:id "cb63-2") (:a (:href "#cb63-2" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " " (:span (:class "at") "--recovery") " " (:span (:class "at") "--generation") " GENERATION-ID"))))
    "
")
  "
")

(:h2 (:id "recover-from-a-crash") "Recover from a crash")

(:p nil
 "If Autolith resumes after a crash, read the diagnosis before asking it to retry the interrupted work.")

(:p nil "To start a rescue session yourself, use:")

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
    (:div (:class "sourceCode" :id "cb64" :data-org-language "sh")
      (:pre (:class "sourceCode bash") (:code (:class "sourceCode bash") (:span (:id "cb64-1") (:a (:href "#cb64-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " open " (:span (:class "at") "--pristine") " " (:span (:class "at") "--permissions") " full"))))
    "
")
  "
")

(:p nil
 "A pristine session skips private replay and executable initialization. Use it to inspect a startup problem without changing the selected generation.")

(:p nil "Saved cores require the recorded SBCL version, OS build and architecture. To reconstruct without a core:")

(:ol nil
  "
"
  (:li nil (:p nil "Check out the revision in the generation manifest."))
  "
"
  (:li nil (:p nil "Run " (:code (:class "verbatim") "./script/bootstrap") "."))
  "
"
  (:li nil (:p nil "Load Autolith in Lisp, then load the ordered " (:code (:class "verbatim") "reconstruct.lisp") " from the manifest in package " (:code (:class "verbatim") "AUTOLITH") ":") "
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
        (:div (:class "sourceCode" :id "cb65" :data-org-language "lisp")
          (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb65-1") (:a (:href "#cb65-1" :aria-hidden "true" :tabindex "-1")) "(asdf:load-asd (" (:span (:class "kw") "truename") " " (:span (:class "st") "\"autolith.asd\"") "))") "
" (:span (:id "cb65-2") (:a (:href "#cb65-2" :aria-hidden "true" :tabindex "-1")) "(asdf:load-system :autolith)") "
" (:span (:id "cb65-3") (:a (:href "#cb65-3" :aria-hidden "true" :tabindex "-1")) "(" (:span (:class "kw") "load") " #P" (:span (:class "st") "\"/path/from/generation/manifest/reconstruct.lisp\"") ")"))))
        "
")
      "
"))
  "
")
