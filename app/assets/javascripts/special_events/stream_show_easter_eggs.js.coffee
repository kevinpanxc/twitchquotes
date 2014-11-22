ready = ->
    $h1 = $("h1")

    if $h1.html().toLowerCase() is "nl_kripp"
        alts = null
        sounds = null
        audio = null

        old_string = $h1.html()

        $h1.mousedown ->
            unless alts?
                alts = [
                    "$ellout"
                    "Casual"
                ]

            unless sounds?
                sounds = [
                    "/assets/nl_kripp_most_ridiculous_comeback_ever.mp3",
                    "/assets/nl_kripp_kripparrian_here.mp3",
                    "/assets/nl_kripp_i_cannot_believe_i_lost.mp3"
                ]   

            $h1.html alts[Math.floor(Math.random() * alts.length)]

            if not audio or audio.paused
                audio = new Audio(sounds[Math.floor(Math.random() * sounds.length)])
                audio.play()
            return

        $h1.mouseup ->
            $h1.html old_string
            return

$(document).ready ready
$(document).on "page:load", ready