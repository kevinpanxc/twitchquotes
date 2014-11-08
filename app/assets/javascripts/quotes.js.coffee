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

    $('#new_quote').submit( ->
        if $("#quote_title").val() is "" or $("#quote_quote").val() is ""
            if $("#quote_title").val() is ""
                $("#quote_title").attr "placeholder", "Title cannot be empty!"
                $("#quote_title").css "border", "2px solid #F59595"
            else
                $("#quote_title").attr "placeholder", "Quote title (required)"
                $("#quote_title").css "border", "1px solid #bbb"
            if $("#quote_quote").val() is ""
                $("#quote_quote").attr "placeholder", "Quote cannot be empty!"
                $("#quote_quote").css "border", "2px solid #F59595"
            else
                $("#quote_quote").attr "placeholder", "Enter quote here... (required)"
                $("#quote_quote").css "border", "1px solid #bbb"            
            false        
        else
            true
    )
    $("#new_quote_text_art_options").find("div").click ->
            $("#text_art").val($(this).data("value"))
            $(".new_quote_text_art_options_options_active").removeClass "new_quote_text_art_options_options_active"
            $(this).addClass "new_quote_text_art_options_options_active"
            return

  else if $("body").hasClass("quotes_index") or $("body").hasClass("quotes_show")
    $('.copy_clipboard').click( ->
        prompt("Copy to clipboard: Ctrl+C or CMD+C, Enter", $("#quote_content_" + $(this).data("dom-id")).html());
    )

$(document).ready ready
$(document).on "page:load", ready