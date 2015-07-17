left_key_nav = (link, e) ->
  Turbolinks.visit(link)  if e.keyCode is 37
  return
right_key_nav = (link, e) ->
  Turbolinks.visit(link)  if e.keyCode is 39
  return

ready = ->
  document.onkeydown = ->
    if $("body").hasClass("quotes_index") || $("body").hasClass("streams_show")
      next = $(".pagination .next a")
      prev = $(".pagination .previous a")
      next_href = next.attr("href")
      prev_href = prev.attr("href")
      if not next.hasClass("disabled") and not prev.hasClass("disabled")
        document.onkeydown = (e) ->
          left_key_nav prev_href, e
          right_key_nav next_href, e
          return
      else unless next.hasClass("disabled")
        document.onkeydown = (e) ->
          right_key_nav next_href, e
          return
      else
        document.onkeydown = (e) ->
          left_key_nav prev_href, e
          return
    return

$(document).ready ready
$(document).on "page:load", ready