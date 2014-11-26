ready = ->
    if $("body").hasClass("streams_show")
        $h1 = $("h1")

        if $h1.html().toLowerCase() is "nl_kripp"
            alts = null
            sounds = null
            audio = null
            last_played = -1

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
                        "/assets/nl_kripp_i_cannot_believe_i_lost.mp3",
                        "/assets/nl_kripp_top_deck_mind_control.mp3",
                        "/assets/nl_kripp_unreal_rng.mp3"
                    ]   

                $h1.html alts[Math.floor(Math.random() * alts.length)]

                if not audio or audio.paused
                    audio_index = Math.floor(Math.random() * sounds.length)
                    if last_played != -1 and audio_index == last_played
                        if --audio_index < 0
                            audio_index = sounds.length - 1
                    last_played = audio_index
                    audio = new Audio(sounds[audio_index])
                    audio.play()
                return

            $h1.mouseup ->
                $h1.html old_string
                return

$(document).ready ready
$(document).on "page:load", ready