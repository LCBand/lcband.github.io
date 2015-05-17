---
---

$.fn.searchable = () ->
  $table = $(this)
  $html = $('html')
  $overlay = $('<div/>', {
    id: 'searchable-overlay'
  })
  $input = $('<input/>', {
    type: 'text'
    name: 'search'
  })

  $overlay.appendTo $('body')
  $overlay.append $input

  $html.keydown (event) ->
    hasFocus = $input.is(':focus')

    # Pressing any normal key starts/continues search
    if event.which >= 48 and event.which <= 222
      if not $input.is(':focus')
        $overlay.show()
        $input.focus()

    # Pressing Backspace when empty exits search
    if event.which == 8 and $input.val().length == 0 and hasFocus
      $input.blur()
      $overlay.hide()
      event.stopPropagation()
      return false

    # Pressing Escape exists search
    if event.which == 27 and $overlay.is(':visible')
      $input.val('')
      $input.blur()
      $overlay.hide()
      $input.keyup()

  $input.keyup (event) ->
    # Filter table by current value
    $table.find('tbody tr').show().each (index, tr) ->
      $tr = $(tr)
      matchFound = false

      $tr.find('td').each (index, td) ->
        if $(td).text().search($input.val()) >= 0
          matchFound = true
          return false

      $tr.hide() if matchFound == false

  return this;

$ () ->
  $('#repertoire').searchable()
