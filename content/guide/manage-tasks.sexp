(:h1 (:id "manage-tasks") "Manage delegated tasks and jobs")

(:h2 (:id "delegate-a-task") "Delegate a task")

(:p nil "Ask Autolith to delegate work if you want a second pass on a change while you work on something else. For example, try "
 (:em nil "Have another agent review this diff and report any regressions. Do not edit files.") ".")

(:p nil "Include the files to review and what you want back. If you want to follow the work directly, open the child channel from the sidebar.")

(:h2 (:id "task-inspection-and-continuity") "Recover an interrupted job")

(:p nil "Ask Autolith to check which parts of the job finished. Review any files or other changes the job produced before you ask Autolith to resume or retry it.")

(:h2 (:id "isolated-modifying-tasks") "Keep delegated edits in a separate checkout")

(:p nil "If you and another agent need to edit the same project, ask Autolith to delegate the changes in a separate Git worktree. Ask for the patch when the job finishes. Review it before you apply it to your checkout.")
