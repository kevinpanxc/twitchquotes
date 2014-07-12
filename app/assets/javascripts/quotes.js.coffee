preloader = new Image("/assets/default_spinner.GIF")

ready = ->
  if $("body").hasClass("quotes_new") or $("body").hasClass("quotes_create")
    $('#channels_search_form').submit( ->
      $.get(this.action, $(this).serialize(), (-> $('.spinner').hide()), 'script')
      $('#channels').html("")
      $('.spinner').show() # hidden in search.js.erb
      false
    )

    $( "input:text" ).css( "font-size", "14px" )

$(document).ready ready
$(document).on "page:load", ready