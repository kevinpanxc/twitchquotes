ready = ->
    if $("#quote_search_form").length is 1
        $("#search_options").find("div").click ->
            $("#search_type").val($(this).data("value"))
            $(".search_options_active").removeClass "search_options_active"
            $(this).addClass "search_options_active"
            return

$(document).ready ready
$(document).on "page:load", ready