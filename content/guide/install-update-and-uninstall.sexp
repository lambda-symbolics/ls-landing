(:h1 (:id "install-update-and-uninstall") "Install, update, and uninstall")

(:h2 (:id "nix") "Nix")

(:p nil "To launch Autolith without installing a command, run:")

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
    (:div (:class "sourceCode" :id "cb1" :data-org-language "sh")
      (:pre (:class "sourceCode bash") (:code (:class "sourceCode bash") (:span (:id "cb1-1") (:a (:href "#cb1-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "nix") " run github:lambda-symbolics/autolith"))))
    "
")
  "
")

(:p nil "You can pass Autolith arguments after " (:code (:class "verbatim") "--") ". To get a command on your " (:code (:class "verbatim") "PATH") ", use " (:code (:class "verbatim") "nix profile install github:lambda-symbolics/autolith") ".")

(:p nil "Nix supports x86-64 and ARM64 Linux and Apple silicon macOS. On first launch, the images are built under " (:code (:class "verbatim") "${XDG_DATA_HOME:-~/.local/share}/autolith/nix/images/") ".")

(:h2 (:id "linux-binary-release") "Linux, macOS, and BSD")

(:p nil "Inspect the " (:a (:href "https://sh.lambda-symbolics.com/autolith") "shell installer") " before you run it:")

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
    (:div (:class "sourceCode" :id "cb2" :data-org-language "sh")
      (:pre (:class "sourceCode bash") (:code (:class "sourceCode bash") (:span (:id "cb2-1") (:a (:href "#cb2-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "curl") " " (:span (:class "at") "-fsSL") " https://sh.lambda-symbolics.com/autolith " (:span (:class "kw") "|") " " (:span (:class "fu") "sh")))))
    "
")
  "
")

(:p nil "The shell installer selects a package for your operating system and CPU:")

(:ul nil
  "
"
  (:li nil "Linux: x86-64 and ARM64, for glibc and musl")
  "
"
  (:li nil "macOS: Intel and Apple silicon")
  "
"
  (:li nil "FreeBSD, NetBSD, and OpenBSD: x86-64")
  "
")

(:p nil "Make sure that " (:code (:class "verbatim") "~/.local/bin") " is on your " (:code (:class "verbatim") "PATH") " if you use the default command location. Install OpenSSL before running the script. On Linux, also install Bubblewrap (" (:code (:class "verbatim") "bwrap") ") for filesystem and network isolation.")

(:h2 (:id "windows") "Windows")

(:p nil "On Windows x86-64, inspect the " (:a (:href "https://sh.lambda-symbolics.com/autolith.ps1") "PowerShell installer") " before you run it:")

(:div (:class "window code-window")
  "
"
  (:div (:class "window-titlebar")
    "
PowerShell
")
  "
"
  (:div (:class "window-body")
    "
"
    (:div (:class "sourceCode" :id "cb3")
      (:pre (:class "sourceCode powershell") (:code (:class "sourceCode powershell") (:span (:id "cb3-1") (:a (:href "#cb3-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "fu") "Invoke-RestMethod") " https" (:span (:class "op") "://") "sh" (:span (:class "op") ".") (:span (:class "fu") "lambda") (:span (:class "op") "-") "symbolics" (:span (:class "op") ".") (:span (:class "fu") "com") (:span (:class "op") "/") "autolith" (:span (:class "op") ".") (:span (:class "fu") "ps1") " " (:span (:class "op") "|") " " (:span (:class "fu") "Invoke-Expression")))))
    "
")
  "
")

(:p nil "Restart Windows Terminal so that you can use the updated " (:code (:class "verbatim") "PATH") ". Sandboxed commands run in an AppContainer without network access. They can write to the workspace and a private temporary directory.")

(:p nil "The SHA-256 of the release archive is verified before extraction on all platforms. See " (:a (:href "https://github.com/lambda-symbolics/autolith/blob/master/docs/release-service.org") "Release service") " for how archives are published.")

(:h2 (:id "update") "Update")

(:p nil "For a packaged installation, run " (:code (:class "verbatim") "autolith update") " and then start Autolith again. Use " (:code (:class "verbatim") "autolith update --help") " to see the command syntax. To update and restart from a running session, enter " (:code (:class "verbatim") "(update)") ". Your original launch arguments are used for the restart. Automatic update checks run at most once every 20 hours.")

(:p nil "For Nix, update the flake input or upgrade the package in your Nix profile. For a source installation, update the checkout and run the bootstrap command again.")

(:h2 (:id "source-checkout") "Source checkout")

(:ol nil
  "
"
  (:li nil "Install a compatible SBCL as specified in " (:code (:class "verbatim") "sbcl-minimum.version") ". Use " (:code (:class "verbatim") "AUTOLITH_SBCL") " to select a specific runtime.")
  "
"
  (:li nil "Install " (:a (:href "https://www.quicklisp.org/beta/") "Quicklisp") " under " (:code (:class "verbatim") "~/quicklisp") ", along with Rust, CMake, pkg-config, and OpenSSL. On Linux, install Bubblewrap as well.")
  "
"
  (:li nil "From the checkout, run " (:code (:class "verbatim") "./script/bootstrap") ". Use " (:code (:class "verbatim") "./script/check") " to check the build.")
  "
"
  (:li nil "Start Autolith with " (:code (:class "verbatim") "./bin/autolith") ". To run it from other directories, link " (:code (:class "verbatim") "bin/autolith") " into a directory on your " (:code (:class "verbatim") "PATH") ".")
  "
")

(:p nil "Use " (:code (:class "verbatim") "--list") " to see test names, " (:code (:class "verbatim") "--suite NAME") " to select a suite, or " (:code (:class "verbatim") "--test NAME") " to select one test. You can repeat the selectors. For example:")

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
    (:div (:class "sourceCode" :id "cb4" :data-org-language "sh")
      (:pre (:class "sourceCode bash") (:code (:class "sourceCode bash") (:span (:id "cb4-1") (:a (:href "#cb4-1" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "./script/check") " " (:span (:class "at") "--suite") " workspace-resource " (:span (:class "at") "--suite") " fixtures") "
" (:span (:id "cb4-2") (:a (:href "#cb4-2" :aria-hidden "true" :tabindex "-1")) (:span (:class "ex") "./script/check") " " (:span (:class "at") "--test") " test-workspace-file-resources " (:span (:class "at") "--jobs") " 1"))))
    "
")
  "
")

(:p nil "Use " (:code (:class "verbatim") "--jobs") " to set the number of workers and " (:code (:class "verbatim") "--timeout") " to set the time limit per worker in seconds. Selected runs skip the recovery checks.")

(:h2 (:id "windows-source-checkout") "Windows source checkout")

(:ol nil
  "
"
  (:li nil "Install Git for Windows, Rust with the MSVC toolchain, and Quicklisp under " (:code (:class "verbatim") "%USERPROFILE%\\quicklisp") ". Put " (:code (:class "verbatim") "clang") " on " (:code (:class "verbatim") "PATH") " for ColorLisp. You can use OpenSSL 3 from Git for Windows or set " (:code (:class "verbatim") "AUTOLITH_OPENSSL_DIRECTORY") " to the directory that contains it.")
  "
"
  (:li nil "From PowerShell in the checkout, run " (:code (:class "verbatim") ".\\script\\bootstrap.ps1") ". If there is no compatible SBCL, a runtime is downloaded and verified against the checksum in " (:code (:class "verbatim") "sbcl-windows-releases.sha256") ".")
  "
"
  (:li nil "Use " (:code (:class "verbatim") ".\\script\\check.ps1") " to check the build. It accepts the same selectors as " (:code (:class "verbatim") "./script/check") ".")
  "
"
  (:li nil "In Windows Terminal, start " (:code (:class "verbatim") ".\\bin\\autolith.cmd") " or " (:code (:class "verbatim") ".\\bin\\autolith.ps1") ".")
  "
")

(:h2 (:id "uninstall") "Uninstall")

(:ol nil
  "
"
  (:li nil "Stop running sessions.")
  "
"
  (:li nil "Run " (:code (:class "verbatim") "autolith uninstall") ". On Windows, delete the folders listed by the command. On other platforms, review the paths before confirming or pass " (:code (:class "verbatim") "--yes") " if no terminal is attached.")
  "
"
  (:li nil "If you used Nix, remove Autolith from the flake or profile. If you built a checkout, delete the checkout separately.")
  "
")

(:p nil "Uninstalling removes the program and the files it needs to run. Your conversation history, settings, credentials, and private image commits are kept.")
