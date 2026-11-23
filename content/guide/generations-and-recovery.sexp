(:h1 (:id "generations-and-recovery") "Generations and recovery")

(:p nil "Use " (:code (:class "verbatim") "(checkpoint)") " to save the live image as a retained generation. The source checkout must be clean and pass " (:code (:class "verbatim") "./script/check") " on POSIX or " (:code (:class "verbatim") "script\\check.ps1") " on Windows. To allow local changes, use " (:code (:class "verbatim") "(checkpoint :allow-dirty t)") ". Autolith marks the generation dirty because the recorded revision does not describe all of the source.")

(:ul nil
  "
"
  (:li nil (:strong nil "POSIX:") " You can keep using the active session while the image is saved.")
  "
"
  (:li nil (:strong nil "Windows:") " Autolith saves the live heap and restarts through the stable launcher. It resumes the conversation after the saved image passes its probe.")
  "
"
  (:li nil (:strong nil "World server:") " A checkpoint waits for running work and holds new turns. Use " (:code (:class "verbatim") "(checkpoint-cancel)") " to cancel a waiting checkpoint and release turns.")
  "
")

(:p nil "Run " (:code (:class "verbatim") "(generations)") " to list retained images. Run " (:code (:class "verbatim") "(rollback \"GENERATION-ID\")") " to select a compatible image and exit through recovery. In the terminal, " (:code (:class "verbatim") "(rollback)") " opens the picker. From the command line:")

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

(:p nil "Pristine and retained-image sessions use separate world endpoints from the ordinary active image. A retained core must support world startup.")

(:p nil (:strong nil "Automatic recovery") " uses a private clean checkout of the current committed source with " (:code (:class "verbatim") "--pristine") ". It uses a separate recovery core if valid and can fall back to source. Use explicit generation selection to return to an older compatible core.")

(:p nil "After a fatal active failure, Autolith restores the terminal and writes a private crash capsule. Recovery resumes the conversation without duplicating scrollback. With a valid capsule, it queues one read-only diagnosis before ordinary input. The turn can inspect bounded crash context, workspace and tracked source, indexed source and active state. It cannot use shell, MCP, hosted-provider or image tools. It asks before applying a repair.")

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

(:p nil "A manual pristine session skips private image replay, mutation journal reconstruction and executable user initialization. Autolith enables " (:code (:class "verbatim") "--immutable") " and leaves mutation and conversation data on disk. Crash diagnosis requires a valid crash capsule from a supervised recovery.")

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
