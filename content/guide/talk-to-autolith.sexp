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
  "
"
  (:li nil "Run " (:code (:class "verbatim") "(help)") " for an overview or " (:code (:class "verbatim") "(help :commands)") " for the command list.")
  "
"
  (:li nil "Use a keyword for a topic, as in " (:code (:class "verbatim") "(help :conversations)") ". Use a quoted command or a tool name for its arguments, as in " (:code (:class "verbatim") "(help 'open)") " or " (:code (:class "verbatim") "(help \"lisp.eval\")") ". Browse a namespace with " (:code (:class "verbatim") "(help :lisp)") " or use " (:code (:class "verbatim") "(help :all)") " for the full reference.")
  "
"
  (:li nil "Press Tab after =(help = to complete a topic or operation. For command options, press Tab after a command name and a space. For example, complete " (:code (:class "verbatim") "(ste t)") " to request Simple Technical English and " (:code (:class "verbatim") "(ste nil)") " to turn it off.")
  "
")

(:p nil "Use " (:code (:class "verbatim") "?") " followed by whitespace to evaluate one Lisp form in the background. This also works for a bare variable. Input such as " (:code (:class "verbatim") "?text") " or " (:code (:class "verbatim") "??") " is plain text.")

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

(:p nil "Use the printed " (:code (:class "verbatim") "exec:N") " ID to inspect, wait for, or cancel that job: " (:code (:class "verbatim") "(job.get :id \"exec:1\")") ", " (:code (:class "verbatim") "(job.wait :id \"exec:1\")") ", or " (:code (:class "verbatim") "(job.cancel :id \"exec:1\")") ". Replace " (:code (:class "verbatim") "exec:1") " with the ID you received. Click the printed cancellation form to insert it at the prompt. The result and captured output go to the original conversation even if you switch channels. Background Lisp uses EOF for input and reports errors without an interactive restart picker. Submitting a form this way does not start a model turn.")

(:p nil "When local Lisp or a command fails and the restart picker opens, choose " (:strong nil "Ask Autolith why this failed") " to diagnose it while the operation is suspended. Review the proposed recovery before choosing a restart or retry. A retry does not undo effects that happened before the error. Escape during diagnosis returns to the picker; Escape at the picker aborts the failed operation.")

(:p nil "During a model turn, Escape cancels that turn and lets queued steering proceed. Ctrl-C cancels the turn and pauses queued work until your next submission. A second Ctrl-C within the force-exit window exits the application. Use " (:code (:class "verbatim") "(cwd)") " to see the current workspace. If you submit " (:code (:class "verbatim") "(cwd \"../other-project\")") " during a turn, the relative path is resolved when that input reaches its place in the steering queue.")

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

(:p nil "The transcript is above the prompt. Look for " (:code (:class "verbatim") "LIVE") " in the modeline when following new output. Otherwise, read the range of rows that are visible.")

(:ul nil
  "
"
  (:li nil "Use " (:code (:class "verbatim") "PageUp") " and " (:code (:class "verbatim") "PageDown") " to scroll one page, or use the mouse wheel to scroll a few rows.")
  "
"
  (:li nil "Use " (:code (:class "verbatim") "Ctrl-PageUp") " and " (:code (:class "verbatim") "Ctrl-PageDown") " to jump between user and assistant messages. The jump puts the end of the message above the composer, or puts the header at the top if the message is taller than the viewport.")
  "
"
  (:li nil "Use " (:code (:class "verbatim") "Ctrl-Home") " and " (:code (:class "verbatim") "Ctrl-End") " to jump to the oldest and newest retained transcript positions.")
  "
"
  (:li nil "In a hosted channel, press " (:code (:class "verbatim") "Ctrl-S") " to toggle the sidebar. Press " (:code (:class "verbatim") "Ctrl-Space") " to focus it. See " (:a (:href "#local-sessions") "Local sessions") ".")
  "
"
  (:li nil "Drag across the transcript to copy selected text on release. Use " (:code (:class "verbatim") "Shift") " and drag to select whole screen rows in the terminal emulator instead.")
  "
")

(:p nil "Transcript history is separate from the scrollback of the terminal emulator. The viewport keeps about four million characters of recent output in memory. At the oldest retained row, the modeline shows " (:code (:class "verbatim") "(history) loads earlier") ". Run " (:code (:class "verbatim") "(history)") " to load a page of older output.")

(:p nil "When saved memories match your input, a dim " (:code (:class "verbatim") "@ N relevant memories exist") " line appears below your message. It shows how many memories were offered to the model for that request, followed by how many of them are stale or unverified (see the Memories section). Each input gets one notice across tool calls and provider retries.")

(:p nil "Input recall includes every user message, command, and Lisp submission in the conversation. Automatic messages and assistant output are excluded. On first use, the complete input-only sidecar is built from the conversation records; later submissions are appended to it. Resuming reads this sidecar instead of replaying archived transcript chunks. If cache storage is unavailable, recall streams the conversation records directly. The editor keeps the newest 500 inputs, up to a million characters, in memory. Moving past the oldest of them loads the next older page, and leaving history recall releases it again.")

(:p nil "Click a web address in the transcript to open it in your browser. Use " (:code (:class "verbatim") "⧉ copy") " below a code block to copy the source. If you connect over SSH, transcript copies can reach your local clipboard through OSC 52.")

(:p nil "Click a tool call header to insert its Lisp form at the cursor. Submit the form to repeat the call, edit the arguments to change the call, or add a question to ask the model about it. Arrays are spelled as " (:code (:class "verbatim") "(vector ...)") " and objects as " (:code (:class "verbatim") "(dict ...)") ", and argument names with uppercase letters keep their case as " (:code (:class "verbatim") ":|filePath|") " or a string key.")

(:p nil "Click a " (:code (:class "verbatim") "lisp.eval") " input block to expand the complete Lisp source with syntax highlighting. Click it again to collapse it. The selected view persists through resizing and tool completion.")

(:p nil "Lisp evaluation inputs, returned source, and values use rainbow parentheses: matching parentheses share a color, and nesting depths cycle through six colors. Strings, character literals, escaped symbols, and comments do not affect depth.")

(:p nil "Tool argument names emitted with underscores are matched to declared hyphenated names, including nested objects and array items. If both spellings are present, the declared spelling takes precedence.")

(:p nil "A pending tool call starts with " (:code (:class "verbatim") "▸") ". When it finishes, the same header shows a green " (:code (:class "verbatim") "✓") " for success or a red " (:code (:class "verbatim") "!") " for failure. Errors appear beneath the original invocation and arguments. Background handoffs keep " (:code (:class "verbatim") "▸") " until completion. Thanks to @rgbcube for suggesting these outcome markers.")

(:p nil "Autolith reports the session status over the interactive terminal using the " (:a (:href "https://www.superlogical.com/rex/docs/build/program-status") "OSC 7501 Program Status Protocol") " and " (:code (:class "verbatim") "app=autolith") ":")

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
        (:th nil "Status")
        "
"
        (:th nil "When reported")
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
        (:td nil (:code (:class "verbatim") "idle"))
        "
"
        (:td nil "At startup or after cancellation")
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "working"))
        "
"
        (:td nil "During foreground input and resumed model turns")
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "done") " or " (:code (:class "verbatim") "error"))
        "
"
        (:td nil "After success or failure, until the next input or model turn")
        "
")
      "
"
      (:tr nil
        "
"
        (:td nil (:code (:class "verbatim") "blocked"))
        "
"
        (:td nil "For an input selector (" (:code (:class "verbatim") "kind=question") "), an approval (" (:code (:class "verbatim") "kind=permission") "), or authentication (" (:code (:class "verbatim") "kind=auth") ")")
        "
")
      "
")
    "
")
  "
")

(:p nil "Reports include the conversation title. Progress from children and background jobs appears in the transcript. Reports omit prompt text, assignments, results, credentials, and progress estimates.")

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

(:p nil "Use " (:code (:class "verbatim") "resource.read") " to read a file or another resource. For an edit, pass the revision from that read as " (:code (:class "verbatim") ":base-revision") " to " (:code (:class "verbatim") "resource.edit") ". If the resource changed, read it again before editing. For a multi-file " (:code (:class "verbatim") "cl-resources") " change, Autolith checks every staged revision before publishing. If publication fails partway through, Autolith restores the earlier files unless an external change requires manual recovery.")

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

(:p nil "History searches are limited to one channel and match all the search terms. Page by sequence number or read a long record on its own. Use " (:code (:class "verbatim") "(papercuts)") " to list reports, " (:code (:class "verbatim") "(papercut \"ID\")") " to inspect one, or " (:code (:class "verbatim") "(papercut-close \"ID\")") " to close it. Agents can report a harness defect with " (:code (:class "verbatim") "papercut.report") " or assess and close a report through its resource where authorized. Put project bugs and test failures in the plan or agenda rather than the harness reports.")

(:h2 (:id "memories") "Memories")

(:p nil "Use a " (:strong nil "note") " for a preference or convention and a " (:strong nil "fact") " for a value you want to reuse with its evidence. An agent can edit its own notes through " (:code (:class "verbatim") "memory:personal") ". That scope follows the agent across channels and restarts. Top-level agents can also write shared workspace and global memories. Their children can read those shared memories.")

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

(:p nil "Open the memory manager with " (:code (:class "verbatim") "(memories)") ". Press " (:code (:class "verbatim") "/") " to search, Tab to choose between All, Notes, and Facts, and Shift-Tab to choose a scope. Press Enter to read the selected item on a narrow terminal. Use " (:code (:class "verbatim") "n") " to create a note, " (:code (:class "verbatim") "e") " to edit it, " (:code (:class "verbatim") "d") " to forget it or retract an asserted fact, and " (:code (:class "verbatim") "r") " to reload. In the note form, use Tab to move between fields, Space to choose a scope, Shift-Enter for a newline, and Enter to save. Use a full ID or a unique ID prefix when you pass an ID to a command.")

(:p nil "A note can cite a file, a web page, your words, or another memory as a " (:em nil "premise") ". A note is " (:em nil "stale") " if a cited passage disappears from a file or a premise changes. Any notes derived from it become stale too. A note whose only cited files cannot be read is " (:em nil "unverified") ". Inspect the evidence with " (:code (:class "verbatim") "(memory \"ID\")") ". Update the source or premise when you update what the note claims. Retagging a note does not refresh its evidence.")

(:p nil "For agent-written notes, the " (:code (:class "verbatim") "memory-remember") " and " (:code (:class "verbatim") "memory-replace") " operations accept " (:code (:class "verbatim") "sources") " and " (:code (:class "verbatim") "premises") ". Use " (:code (:class "verbatim") "memory:id/ID") " to inspect one note. Workspace file references inside that workspace are relative and can move with an export.")

(:h3 (:id "facts-and-rules") "Facts and rules")

(:p nil "A fact records a typed value and what supports it. For instance, the assertion " (:code (:class "verbatim") "event.start review 2026-10-22T13:00:00Z") " can come from your message or a calendar file. The two sources are kept separately. A derived fact keeps the basis of its premises: a calculation based on an assumption is still an assumption.")

(:p nil "For an example, ask the agent to use the " (:code (:class "verbatim") "appointments") " recipe:")

(:ol nil
  "
"
  (:li nil "Give it the start time of the review, 30 minutes of travel, and a 10-minute buffer.")
  "
"
  (:li nil "Admit the proposed departure rule. Run " (:code (:class "verbatim") "(rules)") " to get its name or ID.")
  "
"
  (:li nil "Change the start from 13:00 to 13:15. The derived departure changes from 12:20 to 12:35 without another model request to run the rule. Run " (:code (:class "verbatim") "(what-changed)") " to see the change and its cause.")
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
    (:div (:class "sourceCode" :id "cb13" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb13-1") (:a (:href "#cb13-1" :aria-hidden "true" :tabindex "-1")) "(rules)") "
" (:span (:id "cb13-2") (:a (:href "#cb13-2" :aria-hidden "true" :tabindex "-1")) "(admit-rule " (:span (:class "st") "\"departure\"") ")") "
" (:span (:id "cb13-3") (:a (:href "#cb13-3" :aria-hidden "true" :tabindex "-1")) "(what-changed)") "
" (:span (:id "cb13-4") (:a (:href "#cb13-4" :aria-hidden "true" :tabindex "-1")) "(why " (:span (:class "st") "\"c4dfffae\"") ")") "
" (:span (:id "cb13-5") (:a (:href "#cb13-5" :aria-hidden "true" :tabindex "-1")) "(retire-rule " (:span (:class "st") "\"departure\"") ")"))))
    "
")
  "
")

(:p nil "Use " (:code (:class "verbatim") "(why \"ID\")") " to inspect the sources, rule and premises of a fact, or the evidence for a note. Use " (:code (:class "verbatim") "(forget \"ID\")") " to retract an asserted fact. If two facts disagree, both are shown as " (:em nil "conflicted") ". A negated premise requires an explicit negative fact; missing information is unknown. Recheck evidence when a cited file changes. Web evidence expires after a week and tool output after a day; observe it again to renew it.")

(:p nil "Agents can inspect " (:code (:class "verbatim") "memory:facts") ", " (:code (:class "verbatim") "memory:claim/ID") ", " (:code (:class "verbatim") "memory:predicates") ", " (:code (:class "verbatim") "memory:rules") " and " (:code (:class "verbatim") "memory:changes") ". The " (:code (:class "verbatim") "memory:recipes") " resource lists " (:code (:class "verbatim") "appointments") " and " (:code (:class "verbatim") "service-dependencies") ". Use " (:code (:class "verbatim") "recipe-use") " on " (:code (:class "verbatim") "memory:facts") " to define the predicates and propose the rules. The same resource accepts " (:code (:class "verbatim") "predicate-define") ", " (:code (:class "verbatim") "fact-assert") ", " (:code (:class "verbatim") "fact-retract") ", and " (:code (:class "verbatim") "rule-propose") ".")

(:p nil "Set " (:code (:class "verbatim") "knowledge-mode") " in " (:code (:class "verbatim") "(settings)") " or through " (:code (:class "verbatim") "AUTOLITH_KNOWLEDGE") ". Use " (:code (:class "verbatim") "active") " to record and recall knowledge, " (:code (:class "verbatim") "passive") " to record without giving facts to the model, or " (:code (:class "verbatim") "off") " to stop recording. The default is " (:code (:class "verbatim") "active") ". To inspect how much of the current conversation was spent on structured knowledge, use:")

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
    (:div (:class "sourceCode" :id "cb14" :data-org-language "lisp")
      (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb14-1") (:a (:href "#cb14-1" :aria-hidden "true" :tabindex "-1")) "(knowledge-usage-report (application-conversation *active-application*))"))))
    "
")
  "
")

(:h3 (:id "plans-methods-gates-and-contracts") "Plans, methods, gates, and contracts")

(:p nil "Use facts when a plan or action depends on something you can check. For the review example, a plan step can say " (:code (:class "verbatim") "Leave at {?leave}") " and require " (:code (:class "verbatim") "event.departure review ?leave") ". Before the departure is known, the step is " (:em nil "blocked") ". When the time changes, the displayed step follows it. A completed step is flagged if its recorded facts later stop holding.")

(:ul nil
  "
"
  (:li nil (:p nil "A " (:em nil "method") " describes how to do a task under stated conditions. Ask the agent to run " (:code (:class "verbatim") "plan.expand") " to expand a task into ordered steps. Inspect definitions in " (:code (:class "verbatim") "memory:methods") "."))
  "
"
  (:li nil (:p nil "A " (:em nil "fact gate") " checks a mission against accepted evidence. By default it requires an undisputed observation or a statement from you. For example:") "
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
        (:div (:class "sourceCode" :id "cb15" :data-org-language "lisp")
          (:pre (:class "sourceCode commonlisp") (:code (:class "sourceCode commonlisp") (:span (:id "cb15-1") (:a (:href "#cb15-1" :aria-hidden "true" :tabindex "-1")) "(:id " (:span (:class "st") "\"departure-known\"") " :kind :fact :pattern (" (:span (:class "st") "\"event.departure\"") " " (:span (:class "st") "\"review\"") " " (:span (:class "st") "\"?t\"") "))"))))
        "
")
      "
"))
  "
"
  (:li nil (:p nil "A tool " (:em nil "contract") " can require facts before a call and record facts from its result. For example, require a verified destination before publishing a report. If the prerequisite fails, the tool is not called. A predicted effect only counts if the contract explicitly accepts it."))
  "
")

(:p nil "Agents propose methods and contracts with " (:code (:class "verbatim") "method-define") " and " (:code (:class "verbatim") "contract-define") " on " (:code (:class "verbatim") "memory:facts") ". Inspect contracts in " (:code (:class "verbatim") "memory:contracts") ". Review the complete " (:code (:class "verbatim") "contract.admit") " request before enabling a new version. Imported contracts also need local approval. A tool result marked " (:code (:class "verbatim") "externalSuccess: true") " and " (:code (:class "verbatim") "contractRecording: \"failed\"") " means the action succeeded and only the evidence recording failed. Check the result before retrying. If damaged contracts block ordinary calls, ask the agent to call " (:code (:class "verbatim") "contracts.reset") ". This archives the original log and clears all contracts and saved diagnoses without clearing facts or notes.")

(:h3 (:id "learned-procedures") "Learned procedures")

(:p nil "When three successful turns in a workspace repeat a sequence of tool calls, Autolith can learn a " (:em nil "procedure") " locally. For example, after repeated requests such as " (:code (:class "verbatim") "Make the sales report for q5.") ", a notice may name " (:code (:class "verbatim") "make-sales-report") " and offer it for later requests with another file. Use " (:code (:class "verbatim") "(procedures)") " to see its calls, parameters, status and measured savings in model requests and tokens.")

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

(:p nil "Replace the name and parameters with those listed for your procedure. The first run normally asks you to admit the procedure, and its calls still follow tool approvals and contracts. An exact request pattern can run automatically once the admitted version has demonstrated savings on completed turns. An approximate match is only offered to the model. Two consecutive failed runs suspend the procedure; use " (:code (:class "verbatim") "(admit-procedure \"NAME\")") " after you check it. Use " (:code (:class "verbatim") "(retire-procedure \"NAME\")") " to prevent further runs and relearning. Agents inspect procedures at " (:code (:class "verbatim") "memory:procedures") " and invoke them with " (:code (:class "verbatim") "procedure.run") ". Learning and recall require active structured knowledge.")

(:h3 (:id "diagnosis") "Diagnosis")

(:p nil "Ask Autolith to diagnose a failure when more than one cause fits. With structured knowledge active, the agent can use " (:code (:class "verbatim") "diagnosis.run") " to compare up to four hypotheses with existing facts and up to three tool probes. Each probe needs a contract that records what the result establishes. An observation can rule out a cause; missing evidence leaves the case open.")

(:p nil "For example, if a report fails to reach a service, check whether the service is reachable and whether the configured endpoint is current. A successful reachability probe rules out an outage; a stale endpoint gives you a specific setting to fix. Use " (:code (:class "verbatim") "(diagnoses)") " to review the evidence and saved diagnoses. Disable probes in " (:code (:class "verbatim") "(settings)") " or with " (:code (:class "verbatim") "AUTOLITH_DIAGNOSIS=0") ".")

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

(:p nil "Export includes conversations, notes, facts, rules, agendas, plans, papercuts and related assets. Copy the repository separately. Credentials, configuration, images and caches are excluded. Omit " (:code (:class "verbatim") "--workspace") " to export all workspaces and global data, or pass " (:code (:class "verbatim") "--all") " explicitly (" (:code (:class "verbatim") ":all t") " in Lisp).")

(:p nil "Pick a new filename for export. Import merges data by stable ID, skips identical records and stops before publication on an ID conflict. Use " (:code (:class "verbatim") "--workspace") " on import to relocate a single-workspace archive. Without it, the original paths are preserved. Run " (:code (:class "verbatim") "autolith data export --help") " or " (:code (:class "verbatim") "autolith data import --help") " for options. CLI exit codes are 0 for success, 64 for invalid arguments and 1 for a transfer failure.")

(:h2 (:id "session-titles-and-resume") "Session titles and resume")

(:p nil "A channel gets a local title from your first prompt or image. Autolith can ask the model to refine the title after the third user turn and name the agent after three user turns or 25 tool calls. Use " (:code (:class "verbatim") "(rename \"NAME\")") " to name the current agent yourself. That name takes precedence over automatic naming. Inspect or change the setting with " (:code (:class "verbatim") "(settings :session-title-generation-p)") " or " (:code (:class "verbatim") "(settings :session-title-generation-p nil)") ".")

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

(:p nil "Reopening a live channel gives you its jobs and history. If Autolith needs to serve the conversation in a new process, the history is available, but old background jobs and Lisp worker state are gone. Durable child task results can still be read with " (:code (:class "verbatim") "job.get") ".")

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

(:p nil "From the OS shell, run " (:code (:class "verbatim") "autolith usage") " for stored conversation and knowledge counts, logical disk usage, and resident memory (RSS) of reachable processes. The disk total counts overlapping roots and hard links only once. RSS can count shared pages once per process. Run " (:code (:class "verbatim") "autolith status") " instead to inspect running channels and the server. Set " (:code (:class "verbatim") "NO_COLOR") " for plain output in a terminal.")

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

(:p nil "An idle channel can unload after " (:code (:class "verbatim") "(config :channel-idle-minutes)") " minutes (30 by default) if nothing is running or queued and no terminal shows it. Open it again or send its agent a message to serve it again. If you pipe a script into " (:code (:class "verbatim") "autolith") " or " (:code (:class "verbatim") "autolith open ID") ", submissions run in order and the transcript goes to standard output. A script cannot answer interactive approvals. The channel closes when input ends.")

(:h3 (:id "checkpoints-and-launch-options") "Checkpoints and launch options")

(:p nil "Run " (:code (:class "verbatim") "(checkpoint)") " to save the shared process. Work already in progress finishes first, across all channels. New turns wait until after the save. Terminals reconnect automatically, and the requesting channel receives the generation ID. On Windows, the launcher restarts the server from the saved heap.")

(:p nil "If you lose a connection unexpectedly, press " (:code (:class "verbatim") "r") " or Enter to retry the same channel, enter an ID to switch, or press " (:code (:class "verbatim") "q") " to detach. Retrying does not resubmit your work.")

(:p nil "Use " (:code (:class "verbatim") "--model") ", " (:code (:class "verbatim") "--permissions") " or " (:code (:class "verbatim") "--immutable") " when creating a channel. Pair " (:code (:class "verbatim") "--provider") " with " (:code (:class "verbatim") "--model") ". When opening an existing channel, the only launch override you can pass is " (:code (:class "verbatim") "--permissions") ", and only when no terminal controls it. To choose a permission mode in the channel, run " (:code (:class "verbatim") "(permissions)") ".")

(:h3 (:id "channel-sidebar") "Channel sidebar")

(:p nil "Unfold " (:strong nil "home") " to find channels grouped by repository or workspace. Linked worktrees share a group when Autolith can identify their originating checkout. Independent clones have separate groups. Child channels are nested under their parent. Home shows the inbox and its unread count.")

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

(:p nil "Run " (:code (:class "verbatim") "autolith status") " to list live sessions or " (:code (:class "verbatim") "autolith status --sexp") " for use in Lisp scripts. The controlling terminal has its own PID, distinct from the server PID. In the S-expression, use " (:code (:class "verbatim") ":terminal-client-pid") " for the controller, " (:code (:class "verbatim") ":observer-client-pids") " for read-only clients and " (:code (:class "verbatim") ":pid") " for the host.")

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

(:p nil "Use " (:code (:class "verbatim") "start") " to launch the server in the background, " (:code (:class "verbatim") "tell") " to submit input, " (:code (:class "verbatim") "pause") " to cancel active work and hold queued work, or " (:code (:class "verbatim") "detach") " to disconnect the client. You may omit the target from " (:code (:class "verbatim") "pause") " and " (:code (:class "verbatim") "detach") " when exactly one endpoint is reachable. Use " (:code (:class "verbatim") "tell") " for an unloaded channel too. Its agent is started without a terminal.")

(:p nil "A message beginning with " (:code (:class "verbatim") "(") " is evaluated as Lisp in the target. Supply all arguments and read the result or error in the target transcript. The shell command acknowledges routing and does not wait for the result. Interactive pickers and confirmations are unavailable through " (:code (:class "verbatim") "autolith tell") ".")

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

(:p nil "Endpoint records, leases and recovery state are under the state root. The management REPL socket defaults to " (:code (:class "verbatim") "management/repl.sock") " there on platforms with filesystem sockets. Channel clients use private authenticated loopback connections.")

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

(:p nil "Address a channel by agent handle, exact path, full ID or unique ID fragment. For " (:code (:class "verbatim") "autolith open") ", a bare agent name works too. Use a full ID in a bookmark or script if the names may change. A path follows channel ancestry and can change when an agent is renamed. Copy the displayed path, including case and percent escapes. Find paths with " (:code (:class "verbatim") "(open)") " or " (:code (:class "verbatim") "channel:list") ". Use " (:code (:class "verbatim") "(tell)") " to pick a recipient and prepare a message. Use " (:code (:class "verbatim") "(rename \"WHO\" \"NAME\")") " to rename a participant. Handles accept letters, digits, hyphens and underscores and are matched without regard to case.")

(:p nil "Use a mention such as " (:code (:class "verbatim") "@researcher please check this") " to send a copy to a participant from your current conversation. A mention starts a word, so the " (:code (:class "verbatim") "@") " inside a mail address does not count. To send directly, use " (:code (:class "verbatim") "(tell \"ID\" \"text\")") ". Agents use " (:code (:class "verbatim") "channel.send") " and can follow other channels through " (:code (:class "verbatim") "channel.subscribe") " and " (:code (:class "verbatim") "channel.unsubscribe") ". Subscribers receive copies of messages and replies. An agent can use " (:code (:class "verbatim") "@parent") " to reach its nearest active ancestor or, if there is none, you.")

(:p nil "An idle agent starts work when it receives a message. A working agent receives it as steering. Messages for you go to the inbox. Open it with " (:code (:class "verbatim") "(open \"inbox\")") " and use the " (:code (:class "verbatim") "open") " form at the end of a notice to jump to its source. Read a child agent transcript at " (:code (:class "verbatim") "channel:id/ID") ", where " (:code (:class "verbatim") "ID") " is its execution ID. Child channels nest under the parent; " (:code (:class "verbatim") "AUTOLITH_TASK_MAX_DEPTH") " defaults to three levels below a top-level agent.")
