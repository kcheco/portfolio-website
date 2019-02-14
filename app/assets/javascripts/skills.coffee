ready = undefined
set_positions = undefined

set_positions = ->
  $('.skill-item').each (i) ->
    $(this).attr "data-pos", i + 1
    return
  return

ready = ->
  set_positions()

  $('.sortable').sortable()

  $('.sortable').sortable().bind "sortupdate", (e, ui) ->
    updated_order = []

    set_positions()
    $('.skill-item').each (i) ->
      updated_order.push
        id: $(this).data("skill-id")
        orderno: i + 1
      return

    $.ajax
      type: 'PUT'
      url: '/admin/skills/sort'
      data: skill: updated_order
    return
  return

$(document).ready ready