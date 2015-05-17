---
---
ignoreThe = (node) ->
  text = $(node).text()
  text = text.replace /^the /i, ''
  text = text.replace /^\(.+\) /i, ''
  return text

$ () ->
  $('.sortable').tablesorter {
    textExtraction: ignoreThe
    sortList: [[0,0]]
  }
