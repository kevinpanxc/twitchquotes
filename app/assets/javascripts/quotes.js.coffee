jQuery ->
  # Ajax search on submit
  $('#channels_search').submit( ->
    $.get(this.action, $(this).serialize(), null, 'script')
    $('#channels').html("Loading")
    false
  )

  $( "input:text" ).css( "font-size", "14px" )

  # Ajax search on keyup
  #$('#channels_search input').keyup( ->
  #  $.get($("#channels_search").attr("action"), $("#channels_search").serialize(), null, 'script')
  #  false
  #)