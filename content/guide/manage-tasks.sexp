(:h1 (:id "manage-tasks") "Manage delegated tasks and jobs")

(:h2 (:id "child-roles") "Set up a child role")

(:ol nil
 (:li nil
  (:p nil "Save a role as a " (:code nil "*.sexp") " file under " (:code nil ".autolith/agents/")
   " for the project or beside " (:code nil "init.lisp") " under " (:code nil "agents/")
   " for personal use:")
  (:div (:class "window code-window") "
"
   (:div (:class "window-titlebar") "
Common Lisp
")
   "
"
   (:div (:class "window-body") "
"
    (:div (:class "sourceCode" :id "cb48" :data-org-language "lisp")
     (:pre (:class "sourceCode commonlisp")
      (:code (:class "sourceCode commonlisp")
       (:span (:id "cb48-1") (:a (:href "#cb48-1" :aria-hidden "true" :tabindex "-1")) "("
        (:span (:class "bu") ":name") "             " (:span (:class "st") "\"reviewer\""))
       "
"
       (:span (:id "cb48-2") (:a (:href "#cb48-2" :aria-hidden "true" :tabindex "-1"))
        " :description      " (:span (:class "st") "\"Review a change for regressions.\""))
       "
"
       (:span (:id "cb48-3") (:a (:href "#cb48-3" :aria-hidden "true" :tabindex "-1"))
        " :instructions     " (:span (:class "st") "\"Report concrete, evidence-backed findings.\""))
       "
"
       (:span (:id "cb48-4") (:a (:href "#cb48-4" :aria-hidden "true" :tabindex "-1"))
        " :tools            (" (:span (:class "st") "\"resource.read\"") " "
        (:span (:class "st") "\"search.*\"") ")")
       "
"
       (:span (:id "cb48-5") (:a (:href "#cb48-5" :aria-hidden "true" :tabindex "-1"))
        " :spawns           " (:span (:class "kw") "nil"))
       "
"
       (:span (:id "cb48-6") (:a (:href "#cb48-6" :aria-hidden "true" :tabindex "-1"))
        " :models           (" (:span (:class "st") "\"@parent\"") ")")
       "
"
       (:span (:id "cb48-7") (:a (:href "#cb48-7" :aria-hidden "true" :tabindex "-1"))
        " :reasoning-effort :high)"))))
    "
")
   "
"))
 (:li nil "Use " (:code nil "child.roles")
  " to check that you can select the role. Project roles take precedence over personal roles and site roles.")
 (:li nil "Ask Autolith to delegate a task to the role, or use " (:code nil "child.spawn") "."))

(:h2 (:id "completion-driven-turns") "Choose how to receive job results")

(:ul nil
 (:li nil "Use " (:code nil "completion-policy: continue")
  " to have Autolith pick up the result automatically in the terminal or ACP session. This is the default.")
 (:li nil "Use " (:code nil "completion-policy: notify") " to see the result on your next turn.")
 (:li nil "Use " (:code nil "job.get") " to inspect a job, or " (:code nil "job.wait")
  " to wait for the result."))

(:h2 (:id "task-inspection-and-continuity") "Recover an interrupted job")

(:ol nil
 (:li nil "Use " (:code nil "job.continuity") " with " (:code nil "action: list") " or "
  (:code nil "action: get") " to inspect the job. Check what it did before you repeat it.")
 (:li nil "If the job needs to run again, the primary owner must authorise the restart. Use "
  (:code nil "allow-restart") " with a safety rationale, or " (:code nil "checkpoint")
  " if you have a compatible saved worker image.")
 (:li nil "Use " (:code nil "revive") " to recover the job, or " (:code nil "abandon")
  " to close it. Pass the job ID and " (:code nil "authorize: true") "."))

(:h2 (:id "isolated-modifying-tasks") "Delegate work in a separate Git checkout")

(:ol nil
 (:li nil "Pass " (:code nil "isolation: {}") " to " (:code nil "child.spawn") " to start from "
  (:code nil "HEAD") ". Use " (:code nil "baseline")
  " to specify a different commit. If you want to exclude pending changes, pass "
  (:code nil "dirtyPolicy: ignore") " in the isolation options.")
 (:li nil
  "Ask the child to stage new files before it yields so that they are included in the patch.")
 (:li nil "Review the artifact from the job with " (:code nil "child.worktree") " and "
  (:code nil "action: inspect") ".")
 (:li nil "Use " (:code nil "action: check") " to check whether the patch applies. If it does, use "
  (:code nil "action: apply") " to apply it to the clean target checkout."))

(:p nil
 "Use worktrees to prevent accidental overlap between edits. A worktree does not isolate hostile code.")

(:h2 (:id "reusable-shell-sessions") "Reuse a shell")

(:p nil "Pass a " (:code nil "session") " name to " (:code nil "shell.run")
 " to keep the working directory and variables between commands on POSIX systems. Use "
 (:code nil "shell.reset") " to replace the shell after it exits and " (:code nil "shell.close")
 " to stop it when you are done.")

(:h2 (:id "retained-command-output") "Read earlier command output")

(:p nil "Copy the " (:code nil "shell-log:")
 " reference from the result or from job inspection. Pass it to " (:code nil "resource.read")
 " with " (:code nil "query") " to search the output, or use " (:code nil "byte-offset") " and "
 (:code nil "byte-count") " to read a page.")
