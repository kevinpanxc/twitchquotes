left_key_nav = (link, e) ->
  if e.keyCode is 37
    Turbolinks.visit(link)
    return true
  else
    return false
right_key_nav = (link, e) ->
  if e.keyCode is 39
    Turbolinks.visit(link)
    return true
  else
    return false

ready = ->
  if $("body").hasClass("quotes_index") || $("body").hasClass("streams_show")
    pressed = false
    next = $(".pagination .next a")
    prev = $(".pagination .previous a")
    next_href = next.attr("href")
    prev_href = prev.attr("href")
    if not next.hasClass("disabled") and not prev.hasClass("disabled")
      document.onkeydown = (e) ->
        if ($("body").hasClass("quotes_index") || $("body").hasClass("streams_show") and not pressed)
          pressed = (left_key_nav prev_href, e) or (right_key_nav next_href, e)
          return
    else unless next.hasClass("disabled")
      document.onkeydown = (e) ->
        if ($("body").hasClass("quotes_index") || $("body").hasClass("streams_show") and not pressed)
          pressed = right_key_nav next_href, e
          return
    else
      document.onkeydown = (e) ->
        if ($("body").hasClass("quotes_index") || $("body").hasClass("streams_show") and not pressed)
          pressed = left_key_nav prev_href, e
          return
  return

$(document).ready ready
$(document).on "page:load", ready