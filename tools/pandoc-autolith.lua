local labels = {
  bash = "Shell", sh = "Shell", lisp = "Common Lisp",
  commonlisp = "Common Lisp", ["emacs-lisp"] = "Emacs Lisp",
  json = "JSON", yaml = "YAML", javascript = "JavaScript",
  powershell = "PowerShell", example = "Example"
}

function CodeBlock(element)
  local language = element.attributes["org-language"] or element.classes[1] or "Code"
  local label = labels[language] or language
  local title = pandoc.Div({pandoc.Plain({pandoc.Str(label)})},
                           pandoc.Attr("", {"window-titlebar"}))
  local body = pandoc.Div({element}, pandoc.Attr("", {"window-body"}))
  return pandoc.Div({title, body}, pandoc.Attr("", {"window", "code-window"}))
end

function Table(element)
  return pandoc.Div({element}, pandoc.Attr("", {"table-scroll"}))
end

function Link(element)
  if element.target == "../README.org" then
    element.target = "https://github.com/lambda-symbolics/autolith/blob/master/README.org"
  elseif element.target == "release-service.org" then
    element.target = "https://github.com/lambda-symbolics/autolith/blob/master/docs/release-service.org"
  end
  return element
end
