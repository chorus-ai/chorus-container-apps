quarto.doc.add_html_dependency({
  name = "alpinejs",
  version = "3.12.2",
  scripts = {
    { path = "alpine@3.12.2.min.js", attribs = { defer = "" } }
  }
})
quarto.doc.include_file("in-header", "alpinejs.html")
