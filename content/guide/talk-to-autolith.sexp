(:h1 (:id "talk-to-autolith") "Talk to Autolith")

(:h2 (:id "prose-lisp-and-commands") "Prose, Lisp, and commands")

(:p nil "Type a request in plain text to send it to the current channel. For example, ask Autolith to review a change and name the file or test you want it to check. Type " (:code (:class "verbatim") "@") " to complete a workspace path or a participant handle. A token that contains a slash is treated as a path.")

(:p nil "Start input with " (:code (:class "verbatim") "(") " to evaluate Common Lisp in the active image. Autolith passes the form and its result to the model. The form has its normal effects in that image. To send text from a file, or to attach an image, use " (:code (:class "verbatim") "channel.send") ":")

(:div (:class "window code-window")
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
    (:div (:class "sourceCode" :id "cb6" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb6-1") (:a (:href "#cb6-1" :aria-hidden "true" :tabindex "-1")) "(channel.send :text (read-file " (:span (:class "st") "\"request.org\"") "))") "
" (:span (:id "cb6-2") (:a (:href "#cb6-2" :aria-hidden "true" :tabindex "-1")) "(channel.send :channel " (:span (:class "st") "\"@test-review\"") " :text " (:span (:class "st") "\"Run the focused tests.\"") ")") "
" (:span (:id "cb6-3") (:a (:href "#cb6-3" :aria-hidden "true" :tabindex "-1")) "(channel.send :text " (:span (:class "st") "\"Review this diagram\"") " :images #(" (:span (:class "st") "\"/tmp/diagram.png\"") "))"))))
    "
")
  "
")

(:ul nil
 (:li nil "Run " (:code nil "(help)") " for an overview, or " (:code nil "(help :commands)")
  " for a list of commands.")
 (:li nil "Use " (:code nil "(help :conversations)") " for a topic, or " (:code nil "(help 'open)")
  " for the arguments of a command.")
 (:li nil "Press Tab after a command name and a space to complete an argument."))

(:h3 (:id "background-lisp") "Run Lisp in the background")

(:p nil "Type " (:code nil "?")
 ", a space, and one Lisp form. This runs the form without starting a model turn.")

(:div (:class "window code-window")
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
    (:div (:class "sourceCode" :id "cb7" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb7-1") (:a (:href "#cb7-1" :aria-hidden "true" :tabindex "-1")) "? " (:span (:class "va") "*package*")) "
" (:span (:id "cb7-2") (:a (:href "#cb7-2" :aria-hidden "true" :tabindex "-1")) "? (" (:span (:class "kw") "progn") " (" (:span (:class "kw") "sleep") " " (:span (:class "dv") "10") ") (" (:span (:class "kw") "values") " :finished " (:span (:class "dv") "42") "))"))))
    "
")
  "
")

(:p nil "Replace " (:code nil "exec:1") " in these examples with the job ID you receive:")

(:ul nil (:li nil "Inspect it with " (:code nil "(job.get :id \"exec:1\")") ".")
 (:li nil "Wait for it with " (:code nil "(job.wait :id \"exec:1\")") ".")
 (:li nil "Cancel it with " (:code nil "(job.cancel :id \"exec:1\")") "."))

(:h3 (:id "command-errors") "Recover from a command error")

(:ol nil (:li nil "Choose " (:strong nil "Ask Autolith why this failed") " in the restart picker.")
 (:li nil
  "Review the proposed recovery before you choose a restart. A retry does not undo earlier effects.")
 (:li nil
  "Press Escape to return to the picker from diagnosis. Press Escape in the picker to abort the operation."))

(:h3 (:id "interrupt-a-turn") "Interrupt a turn")

(:ul nil (:li nil "Press Escape to cancel the turn and allow queued input to proceed.")
 (:li nil "Press Ctrl-C to cancel the turn and pause queued work until you submit new input."))

(:h2 (:id "command-arguments") "Command arguments")

(:p nil "Pass Lisp values directly to commands:")

(:ul nil
  "
"
  (:li nil "Use keywords for actions, such as " (:code (:class "verbatim") ":refresh") " in " (:code (:class "verbatim") "(mcp :refresh)") ".")
  "
"
  (:li nil "Use " (:code (:class "verbatim") "t") " to enable a setting and " (:code (:class "verbatim") "nil") " to disable it. Omit the value to inspect the setting.")
  "
"
  (:li nil "Use numbers for quantities and strings for text or identifiers. Pass pathnames and quoted Lisp data directly rather than spelling them out in strings.")
  "
")

(:div (:class "window code-window")
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
    (:div (:class "sourceCode" :id "cb8" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb8-1") (:a (:href "#cb8-1" :aria-hidden "true" :tabindex "-1")) "(settings :boot-screen-seconds " (:span (:class "dv") "2") ")") "
" (:span (:id "cb8-2") (:a (:href "#cb8-2" :aria-hidden "true" :tabindex "-1")) "(settings :reasoning-traces-p " (:span (:class "kw") "t") ")") "
" (:span (:id "cb8-3") (:a (:href "#cb8-3" :aria-hidden "true" :tabindex "-1")) "(settings :reasoning-traces-p " (:span (:class "kw") "nil") ")"))))
    "
")
  "
")

(:h3 (:id "automatic-permissions") "Automatic permissions")

(:p nil "Choose a permission mode for the channel:")

(:ul nil
  "
"
  (:li nil (:code (:class "verbatim") "(permissions :ask)") " prompts for approval. Choose " (:code (:class "verbatim") "once") " for one operation or " (:code (:class "verbatim") "always") " to approve the exact operation for future calls.")
  "
"
  (:li nil (:code (:class "verbatim") "(permissions :auto)") " classifies operations without an approval prompt. While Autolith classifies the call, look for " (:code (:class "verbatim") "judging") " in the status bar. Read the decision beside the tool call.")
  "
"
  (:li nil "Use " (:code (:class "verbatim") "(permissions :sandbox)") " for sandboxed execution on supported platforms.")
  "
"
  (:li nil "Use " (:code (:class "verbatim") "(permissions :full)") " to run with your full user privileges.")
  "
")

(:p nil "The mode is stored locally and restored when you reopen a saved channel. This includes " (:strong nil "full") " access, even after a restart.")

(:h2 (:id "read-the-transcript") "Read the transcript")

(:p nil "Read the transcript above the prompt. The status line shows " (:code nil "LIVE")
 " if you are following new output.")

(:ul nil (:li nil "Press PageUp or PageDown to scroll by a page.")
 (:li nil "Use Ctrl-PageUp or Ctrl-PageDown to jump between messages.")
 (:li nil
  "Use Ctrl-Home or Ctrl-End to jump to the oldest or newest position in the loaded transcript."))

(:p nil "Run " (:code nil "(history)")
 " to load earlier messages if you have reached the top of the loaded transcript.")

(:h3 (:id "transcript-actions") "Recall input and copy text")

(:ul nil (:li nil "Use input history to recall your own messages, commands and Lisp forms.")
 (:li nil
  "Drag across the transcript to copy text. Hold Shift while dragging to select rows in the terminal emulator instead.")
 (:li nil "Use " (:strong nil "⧉ copy") " below a code block to copy the source.")
 (:li nil
  "Click a tool call to insert the Lisp form at the prompt. Edit the arguments before you submit the form if you want a different call.")
 (:li nil "Click a " (:code nil "lisp.eval") " input block to expand or collapse the source."))

(:p nil
 "Look for ▸ while a tool call is pending, ✓ after success, and ! after failure. Read any error below the call. Thanks to @rgbcube for suggesting these markers.")

(:h3 (:id "terminal-diagrams") "Terminal diagrams")

(:p nil "Ask for a fenced " (:code (:class "verbatim") "mermaid") " block to see a diagram in the terminal. " (:a (:href "https://github.com/lambda-symbolics/clermaid") "Clermaid") " documents the supported syntax for:")

(:ul nil
  "
"
  (:li nil "Flowcharts")
  "
"
  (:li nil "Sequence diagrams")
  "
"
  (:li nil "Flat state diagrams")
  "
"
  (:li nil "Class diagrams")
  "
"
  (:li nil "Entity relationship diagrams")
  "
")

(:div (:class "window code-window")
  "
"
  (:div (:class "window-titlebar")
    "
markdown
")
  "
"
  (:div (:class "window-body")
    "
"
    (:div (:class "sourceCode" :id "cb9")
      (:pre (:class "sourceCode markdown") (:code (:class "sourceCode markdown") (:span (:id "cb9-1") (:a (:href "#cb9-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "in") "```mermaid")) "
" (:span (:id "cb9-2") (:a (:href "#cb9-2" :aria-hidden "true" :tabindex "-1")) (:span (:class "in") "flowchart LR")) "
" (:span (:id "cb9-3") (:a (:href "#cb9-3" :aria-hidden "true" :tabindex "-1")) (:span (:class "in") "  A[Read] --> B[Evaluate]")) "
" (:span (:id "cb9-4") (:a (:href "#cb9-4" :aria-hidden "true" :tabindex "-1")) (:span (:class "in") "  B --> C[Print]")) "
" (:span (:id "cb9-5") (:a (:href "#cb9-5" :aria-hidden "true" :tabindex "-1")) (:span (:class "in") "```")))))
    "
")
  "
")

(:p nil "While the response streams, read the Mermaid source in the live tail. Use the " (:strong nil "copy") " action on the finished diagram to copy the source. If the syntax is unsupported or the diagram is too wide, read the source block instead.")

(:h2 (:id "parking-and-editing-queued-input") "Parking and editing queued input")

(:ol nil
  "
"
  (:li nil "Run " (:code (:class "verbatim") "(vault-store)") " to park queued work and unconsumed steering. Work already in progress continues.")
  "
"
  (:li nil "Run " (:code (:class "verbatim") "(vault-contents)") " to inspect the parked entries in restoration order. Entries are zero-indexed. Use " (:code (:class "verbatim") "setf") " to publish a change.")
  "
"
  (:li nil "Run " (:code (:class "verbatim") "(vault-restore)") " to put the edited entries at the front of the live queue.")
  "
")

(:div (:class "window code-window")
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
    (:div (:class "sourceCode" :id "cb10" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb10-1") (:a (:href "#cb10-1" :aria-hidden "true" :tabindex "-1")) "(vault-store)") "
" (:span (:id "cb10-2") (:a (:href "#cb10-2" :aria-hidden "true" :tabindex "-1")) "(vault-contents)") "
" (:span (:id "cb10-3") (:a (:href "#cb10-3" :aria-hidden "true" :tabindex "-1")) "(" (:span (:class "kw") "setf") " (vault-contents " (:span (:class "dv") "0") ") '(:message " (:span (:class "st") "\"Run the unit tests first.\"") "))") "
" (:span (:id "cb10-4") (:a (:href "#cb10-4" :aria-hidden "true" :tabindex "-1")) "(vault-restore)"))))
    "
")
  "
")

(:p nil "Use " (:code (:class "verbatim") "(vault)") " for a summary. To replace the entire list, set " (:code (:class "verbatim") "(vault-contents)") " without an index. Its entries may be " (:code (:class "verbatim") "(:message INPUT)") ", " (:code (:class "verbatim") "(:command TEXT)") ", " (:code (:class "verbatim") "(:lisp SOURCE)") " or, for scheduled wakeups, " (:code (:class "verbatim") "(:native-lisp SOURCE)") ". Set the list to " (:code (:class "verbatim") "nil") " to clear it.")

(:h2 (:id "managed-resources") "Managed resources")

(:ol nil (:li nil "Read the resource with " (:code nil "resource.read") ".")
 (:li nil "Pass the revision from the read as " (:code nil ":base-revision") " to "
  (:code nil "resource.edit") ".")
 (:li nil
  "If the edit was rejected because the resource changed, read it again and check the new contents before editing."))

(:div (:class "window code-window")
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
    (:div (:class "sourceCode" :id "cb11" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb11-1") (:a (:href "#cb11-1" :aria-hidden "true" :tabindex "-1")) "(resource." (:span (:class "kw") "read") " :uri " (:span (:class "st") "\"workspace:README.md\"") ")") "
" (:span (:id "cb11-2") (:a (:href "#cb11-2" :aria-hidden "true" :tabindex "-1")) "(resource." (:span (:class "kw") "read") " :uri " (:span (:class "st") "\"channel:current\"") " :query " (:span (:class "st") "\"unit tests\"") " :max-results " (:span (:class "dv") "5") ")") "
" (:span (:id "cb11-3") (:a (:href "#cb11-3" :aria-hidden "true" :tabindex "-1")) "(resource." (:span (:class "kw") "read") " :uri " (:span (:class "st") "\"channel:current\"") " :start-sequence " (:span (:class "dv") "120") " :record-count " (:span (:class "dv") "10") ")"))))
    "
")
  "
")

(:div (:class "table-scroll")
  "
"
  (:table nil
    "
"
    (:thead nil
      "
"
      (:tr nil
        "
"
        (:th nil "Resource")
        "
"
        (:th nil "Use")
        "
")
      "
")
    "
"
    (:tbody nil
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "channel:current"))
        "
"
        (:td nil "Read recent history, including records from before compaction.")
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "channel:id/ID"))
        "
"
        (:td nil "Read the history of one other channel.")
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "channel:list"))
        "
"
        (:td nil "Find channels and their participants. Reading does not subscribe you.")
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "papercut:current"))
        "
"
        (:td nil "List active reports about the running Autolith harness or its tools.")
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "papercut:id/ID"))
        "
"
        (:td nil "Read one papercut. Percent-encode the stable ID if necessary.")
        "
")
      "
")
    "
")
  "
")

(:p nil "Search within a single channel. If you have a sequence number, pass it as "
 (:code nil ":start-sequence") " to read from that point.")

(:h2 (:id "memories") "Memories")

(:p nil "Use a " (:strong nil "note") " for preferences or conventions. Use a " (:strong nil "fact")
 " to record a value and the evidence for it.")

(:div (:class "window code-window")
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
    (:div (:class "sourceCode" :id "cb12" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb12-1") (:a (:href "#cb12-1" :aria-hidden "true" :tabindex "-1")) "(memories)") "
" (:span (:id "cb12-2") (:a (:href "#cb12-2" :aria-hidden "true" :tabindex "-1")) "(memories " (:span (:class "st") "\"deploy\"") ")") "
" (:span (:id "cb12-3") (:a (:href "#cb12-3" :aria-hidden "true" :tabindex "-1")) "(memory " (:span (:class "st") "\"3afbfa1a\"") ")") "
" (:span (:id "cb12-4") (:a (:href "#cb12-4" :aria-hidden "true" :tabindex "-1")) "(forget " (:span (:class "st") "\"3afbfa1a\"") ")"))))
    "
")
  "
")

(:p nil "Open the memory manager with " (:code nil "(memories)") ".")

(:ul nil (:li nil "Press / to search.")
 (:li nil "Use Tab to switch between All, Notes and Facts. Use Shift-Tab to choose a scope.")
 (:li nil "Press n to create a note, e to edit one or d to forget the selected entry."))

(:p nil "Use " (:code nil "(memory \"ID\")")
 " to see the evidence. If a source changes, check it before relying on a note marked stale.")

(:h3 (:id "facts-and-rules") "Facts and rules")

(:p nil
 "Facts record values and their sources. Rules derive new facts from those values. For example, a rule can mark a pull request ready for review after the required checks pass.")

(:ul nil
 (:li nil "Use " (:code nil "(why \"ID\")") " to inspect the sources and rules behind a fact.")
 (:li nil "Use " (:code nil "(what-changed)") " to see which facts changed and why.")
 (:li nil "Use " (:code nil "(forget \"ID\")") " to retract an assertion."))

(:h3 (:id "plans-methods-gates-and-contracts") "Plans, methods, gates, and contracts")

(:p nil
 "Use facts for work that depends on evidence you can check, such as whether a pull request can be merged.")

(:ul nil
 (:li nil "A method describes how to do a task. Ask Autolith to use " (:code nil "plan.expand")
  " to turn a task into steps.")
 (:li nil
  "A fact gate checks a claim before mission acceptance. Use one to require evidence that the reviewed changes passed CI.")
 (:li nil
  "A tool contract defines what must be true before a tool runs, or what the result establishes."))

(:h3 (:id "learned-procedures") "Learned procedures")

(:p nil "Autolith can learn a procedure from repeated work. Run " (:code nil "(procedures)")
 " to see the calls, inputs and status of learned procedures.")

(:div (:class "window code-window")
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
    (:div (:class "sourceCode" :id "cb16" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb16-1") (:a (:href "#cb16-1" :aria-hidden "true" :tabindex "-1")) "(procedures)") "
" (:span (:id "cb16-2") (:a (:href "#cb16-2" :aria-hidden "true" :tabindex "-1")) "(admit-procedure " (:span (:class "st") "\"make-sales-report\"") ")") "
" (:span (:id "cb16-3") (:a (:href "#cb16-3" :aria-hidden "true" :tabindex "-1")) "(run-procedure " (:span (:class "st") "\"make-sales-report\"") " :file " (:span (:class "st") "\"q5\"") ")") "
" (:span (:id "cb16-4") (:a (:href "#cb16-4" :aria-hidden "true" :tabindex "-1")) "(retire-procedure " (:span (:class "st") "\"make-sales-report\"") ")"))))
    "
")
  "
")

(:ul nil (:li nil "Review and admit a procedure before reuse. Tool approvals still apply.")
 (:li nil "Use " (:code nil "(retire-procedure \"NAME\")") " to prevent further runs."))

(:h3 (:id "diagnosis") "Diagnosis")

(:p nil
 "Ask Autolith to compare possible causes of a failure. With structured knowledge enabled, it can use "
 (:code nil "diagnosis.run") " to compare hypotheses with recorded facts and tool results.")

(:h2 (:id "exporting-and-importing-data") "Exporting and importing data")

(:p nil "Export a workspace from the OS shell, then import it at its new path:")

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
    (:div (:class "sourceCode" :id "cb17" :data-org-language "sh")
      (:pre (:class "sourceCode bash") (:code (:class "sourceCode bash") (:span (:id "cb17-1") (:a (:href "#cb17-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " data export project.sexp " (:span (:class "at") "--workspace") " /home/al/code/project") "
" (:span (:id "cb17-2") (:a (:href "#cb17-2" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " data import project.sexp " (:span (:class "at") "--workspace") " /home/al/src/project"))))
    "
")
  "
")

(:p nil "Use the same archive format at the Autolith prompt:")

(:div (:class "window code-window")
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
    (:div (:class "sourceCode" :id "cb18" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb18-1") (:a (:href "#cb18-1" :aria-hidden "true" :tabindex "-1")) "(data." (:span (:class "kw") "export") " " (:span (:class "st") "\"project.sexp\"") " :workspace " (:span (:class "st") "\"/home/al/code/project\"") ")") "
" (:span (:id "cb18-2") (:a (:href "#cb18-2" :aria-hidden "true" :tabindex "-1")) "(data." (:span (:class "kw") "import") " " (:span (:class "st") "\"project.sexp\"") " :workspace " (:span (:class "st") "\"/home/al/src/project\"") ")"))))
    "
")
  "
")

(:p nil
 "Use export to move conversations and workspace knowledge together. Copy the archive if you are moving to another machine.")

(:p nil
 "Choose a new file for each export. If the import reports a conflict, review the conflicting record before retrying.")

(:h2 (:id "session-titles-and-resume") "Session titles and resume")

(:p nil "Autolith starts a channel title from your first message. Run "
 (:code nil "(rename \"NAME\")") " to name the current agent yourself.")

(:ul nil
  "
"
  (:li nil "Run " (:code (:class "verbatim") "(channel-id)") " to find the stable ID of the current channel.")
  "
"
  (:li nil "Run " (:code (:class "verbatim") "(open)") " to pick a channel or " (:code (:class "verbatim") "(open \"ID\")") " to open it directly.")
  "
"
  (:li nil "Run " (:code (:class "verbatim") "(delete)") " to remove the displayed channel, or " (:code (:class "verbatim") "(delete \"ID\")") " to choose another. Confirm only if you intend to remove its history and child channels. The subtree must be idle and free of other attached clients.")
  "
")

(:p nil "Open an existing channel to return to the transcript and any retained jobs.")

(:h2 (:id "usage") "Usage")

(:p nil "Run " (:code (:class "verbatim") "(status)") " or its alias " (:code (:class "verbatim") "(usage)") " " (:strong nil "at the Autolith prompt") " for model usage:")

(:ul nil
  "
"
  (:li nil (:strong nil "Token usage") " sums recorded input and output for this conversation. The prompt-cache row shows cache usage when reported by the provider.")
  "
"
  (:li nil (:strong nil "Context") " is the current space used in the model window, not the sum of tokens sent over the conversation.")
  "
"
  (:li nil (:strong nil "Cost") " covers recorded requests in this process. Review any unpriced request count before treating the total as a bill. Subscription rate limits are shown when available.")
  "
")

(:p nil "Run " (:code nil "autolith usage")
 " from the shell to inspect stored conversations and disk usage.")

(:h2 (:id "local-sessions") "Local sessions")

(:h3 (:id "starting-and-switching-channels") "Starting and switching channels")

(:p nil "An interactive " (:code (:class "verbatim") "autolith") " launch starts the background server if needed and serves the inbox. Use the following shell commands to work on a channel:")

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
    (:div (:class "sourceCode" :id "cb19" :data-org-language "sh")
      (:pre (:class "sourceCode bash") (:code (:class "sourceCode bash") (:span (:id "cb19-1") (:a (:href "#cb19-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " open") "
" (:span (:id "cb19-2") (:a (:href "#cb19-2" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " open researcher " (:span (:class "at") "--read-only")) "
" (:span (:id "cb19-3") (:a (:href "#cb19-3" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " open /researcher/reviewer") "
" (:span (:id "cb19-4") (:a (:href "#cb19-4" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " new /home/al/code/project") "
" (:span (:id "cb19-5") (:a (:href "#cb19-5" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " new /home/al/code/project " (:span (:class "at") "--detached")))))
    "
")
  "
")

(:p nil "Without a target, " (:code (:class "verbatim") "autolith open") " opens the last changed top-level channel in the current workspace or creates one if there is none. Use " (:code (:class "verbatim") "autolith new") " for a fresh channel; add " (:code (:class "verbatim") "-d") " or " (:code (:class "verbatim") "--detached") " to create it without attaching. To open it later, use the printed " (:code (:class "verbatim") "autolith open ID") " command. Only one terminal can control a channel. Use " (:code (:class "verbatim") "--read-only") " to observe from another terminal.")

(:p nil "Inside Autolith, use " (:code (:class "verbatim") "(open \"ID\")") " to switch channels. Use " (:code (:class "verbatim") "(detach)") " or Ctrl-Z to disconnect the terminal and leave work running. Use " (:code (:class "verbatim") "(exit)") " to end the channel. To stop " (:strong nil "all") " channels and their server, use " (:code (:class "verbatim") "autolith stop") " from the OS shell or " (:code (:class "verbatim") "(stop-server)") " from Autolith. Updating or rolling back also stops the shared server.")

(:h3 (:id "checkpoints-and-launch-options") "Checkpoints and launch options")

(:p nil "Run " (:code (:class "verbatim") "(checkpoint)") " to save the shared process. Work already in progress finishes first, across all channels. New turns wait until after the save. Terminals reconnect automatically, and the requesting channel receives the generation ID. On Windows, the launcher restarts the server from the saved heap.")

(:p nil "If you lose a connection unexpectedly, press " (:code (:class "verbatim") "r") " or Enter to retry the same channel, enter an ID to switch, or press " (:code (:class "verbatim") "q") " to detach. Retrying does not resubmit your work.")

(:p nil "Use " (:code (:class "verbatim") "--model") ", " (:code (:class "verbatim") "--permissions") " or " (:code (:class "verbatim") "--immutable") " when creating a channel. Pair " (:code (:class "verbatim") "--provider") " with " (:code (:class "verbatim") "--model") ". When opening an existing channel, the only launch override you can pass is " (:code (:class "verbatim") "--permissions") ", and only when no terminal controls it. To choose a permission mode in the channel, run " (:code (:class "verbatim") "(permissions)") ".")

(:h3 (:id "channel-sidebar") "Channel sidebar")

(:p nil "Expand " (:strong nil "home") " to see channels by repository or workspace.")

(:ul nil
  "
"
  (:li nil "Press Ctrl-S to toggle the sidebar. On a narrow terminal it opens as a drawer.")
  "
"
  (:li nil "Click the sidebar or press Ctrl-Space (Ctrl-Tab where supported) to focus it. Use the arrows to select or expand an entry, Enter to open it, or Delete to remove it after confirmation.")
  "
"
  (:li nil "Type to filter by agent name, ID, title or workspace. Press Escape to clear the filter or return focus to the transcript.")
  "
")

(:div (:class "table-scroll")
  "
"
  (:table nil
    "
"
    (:thead nil
      "
"
      (:tr nil
        "
"
        (:th nil "Marker")
        "
"
        (:th nil "Meaning")
        "
")
      "
")
    "
"
    (:tbody nil
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "▌"))
        "
"
        (:td nil "Current channel in this terminal")
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "▸") " / " (:code (:class "verbatim") "▾"))
        "
"
        (:td nil "Closed or open group")
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "●") " / " (:code (:class "verbatim") "○"))
        "
"
        (:td nil "Agent working or hosted but idle")
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "·") " / " (:code (:class "verbatim") "?"))
        "
"
        (:td nil "No running session or unknown status")
        "
")
      "
")
    "
")
  "
")

(:p nil "A yellow number counts messages received since this terminal last viewed the channel. " (:code (:class "verbatim") "@") " counts mentions, and " (:code (:class "verbatim") "N pending") " counts deliveries waiting for a channel that is not loaded.")

(:h3 (:id "session-endpoints") "Session endpoints")

(:p nil "Run " (:code nil "autolith status") " to list active local sessions. Add "
 (:code nil "--sexp") " if you need to read the output from Lisp.")

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
    (:div (:class "sourceCode" :id "cb20" :data-org-language "sh")
      (:pre (:class "sourceCode bash") (:code (:class "sourceCode bash") (:span (:id "cb20-1") (:a (:href "#cb20-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " start") "
" (:span (:id "cb20-2") (:a (:href "#cb20-2" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " tell researcher " (:span (:class "st") "'Review the failing unit test.'")) "
" (:span (:id "cb20-3") (:a (:href "#cb20-3" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " tell /researcher/reviewer " (:span (:class "st") "'(channel-id)'")) "
" (:span (:id "cb20-4") (:a (:href "#cb20-4" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " pause researcher") "
" (:span (:id "cb20-5") (:a (:href "#cb20-5" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "autolith") " detach researcher"))))
    "
")
  "
")

(:ul nil (:li nil "Use " (:code nil "autolith start") " to start the server in the background.")
 (:li nil "Send input to another channel with " (:code nil "autolith tell") ".")
 (:li nil "Use " (:code nil "autolith pause") " to cancel active work and pause queued work, or "
  (:code nil "autolith detach") " to disconnect the terminal."))

(:p nil "With " (:code nil "autolith tell") ", input that begins with " (:code nil "(")
 " is evaluated as Lisp. Supply the arguments in the input and read the result in the target transcript.")

(:p nil "For local backups or diagnostics, these are the default roots. An absolute value for the corresponding XDG variable overrides each default.")

(:div (:class "table-scroll")
  "
"
  (:table nil
    "
"
    (:thead nil
      "
"
      (:tr nil
        "
"
        (:th nil "Purpose")
        "
"
        (:th nil "XDG variable")
        "
"
        (:th nil "POSIX default")
        "
"
        (:th nil "Windows default")
        "
")
      "
")
    "
"
    (:tbody nil
      "
"
      (:tr nil
        "
"
        (:td nil "Configuration")
        "
"
        (:td nil (:code (:class "verbatim") "XDG_CONFIG_HOME"))
        "
"
        (:td nil (:code (:class "verbatim") "~/.config/autolith/"))
        "
"
        (:td nil (:code (:class "verbatim") "%APPDATA%\\autolith\\"))
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil "Durable data")
        "
"
        (:td nil (:code (:class "verbatim") "XDG_DATA_HOME"))
        "
"
        (:td nil (:code (:class "verbatim") "~/.local/share/autolith/"))
        "
"
        (:td nil (:code (:class "verbatim") "%LOCALAPPDATA%\\autolith\\data\\"))
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil "Process state")
        "
"
        (:td nil (:code (:class "verbatim") "XDG_STATE_HOME"))
        "
"
        (:td nil (:code (:class "verbatim") "~/.local/state/autolith/"))
        "
"
        (:td nil (:code (:class "verbatim") "%LOCALAPPDATA%\\autolith\\state\\"))
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil "Cache")
        "
"
        (:td nil (:code (:class "verbatim") "XDG_CACHE_HOME"))
        "
"
        (:td nil (:code (:class "verbatim") "~/.cache/autolith/"))
        "
"
        (:td nil (:code (:class "verbatim") "%LOCALAPPDATA%\\autolith\\cache\\"))
        "
")
      "
")
    "
")
  "
")

(:h2 (:id "channels") "Channels")

(:p nil "A channel has its own history and workspace. Each agent resides in one channel and can subscribe to others. You reside in " (:code (:class "verbatim") "/inbox") ", also shown as " (:strong nil "home") " in the sidebar. Viewing or controlling another channel does not move you there. Typing ordinary text in the inbox starts no agent turn.")

(:div (:class "window code-window")
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
    (:div (:class "sourceCode" :id "cb21" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb21-1") (:a (:href "#cb21-1" :aria-hidden "true" :tabindex "-1")) "(" (:span (:class "kw") "open") " " (:span (:class "st") "\"inbox\"") ")") "
" (:span (:id "cb21-2") (:a (:href "#cb21-2" :aria-hidden "true" :tabindex "-1")) "(tell " (:span (:class "st") "\"@researcher\"") " " (:span (:class "st") "\"Check the release notes.\"") ")") "
" (:span (:id "cb21-3") (:a (:href "#cb21-3" :aria-hidden "true" :tabindex "-1")) "(" (:span (:class "kw") "open") " " (:span (:class "st") "\"/researcher/reviewer\"") ")") "
" (:span (:id "cb21-4") (:a (:href "#cb21-4" :aria-hidden "true" :tabindex "-1")) "(rename " (:span (:class "st") "\"/researcher/reviewer\"") " " (:span (:class "st") "\"critic\"") ")"))))
    "
")
  "
")

(:p nil "Use " (:code nil "(open)")
 " to find a channel by handle, path or ID. Use the full ID in scripts if the name may change.")

(:ul nil
 (:li nil "Type " (:code nil "@researcher please check this")
  " to send a copy of a message to that participant.")
 (:li nil "Use " (:code nil "(tell \"ID\" \"text\")") " to send a message directly."))

(:p nil "Open " (:code nil "(open \"inbox\")")
 " to read messages addressed to you. Use the link in a notice to jump to the source channel.")
