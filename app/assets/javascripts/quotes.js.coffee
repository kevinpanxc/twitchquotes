preloader = new Image("/assets/default_spinner.GIF")

jQuery ->
  # Ajax search on submit
  $('#channels_search_form').submit( ->
    $.get(this.action, $(this).serialize(), (-> $('.spinner').hide()), 'script')
    $('#channels').html("")
    $('.spinner').show() # hidden in search.js.erb
    false
  )

  $(".single_quote_block").hover (->
      $(this).find(".quote_actions").show()
    ), (->
      $(this).find(".quote_actions").hide())

  $( "input:text" ).css( "font-size", "14px" )

  # Ajax search on keyup
  #$('#channels_search input').keyup( ->
  #  $.get($("#channels_search").attr("action"), $("#channels_search").serialize(), null, 'script')
  #  false
  #)