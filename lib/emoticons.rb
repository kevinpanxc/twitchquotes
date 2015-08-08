class Emoticons
    def self.emoticons
        @@emoticons
    end

    def self.asset_path(path)
        ActionController::Base.helpers.asset_path(path)
    end

    def self.refactor_emoticon_quotes()
        # build lower case to actual emote string
        local_case_to_actual = {}
        @@emoticons.keys.each do |key|
            local_case_to_actual["#{key.downcase}"] = "#{key}"
        end

        updated_quote_ids = []

        Quote.all.each do |q|
            if q.quote =~ /<img[^<>]+\/>/
                updated_quote_ids.push(q.id)
                # q.update(quote: q.quote.gsub(/<img[^<>]+\/>/) { |match| "data-emote=\"#{local_case_to_actual[match[/\/([a-zA-Z0-9]+)[-,.]/, 1]]}\" #{match}" })
                q.update(quote: q.quote.gsub(/<img[^<>]+\/>/) { |match| "#{local_case_to_actual[match[/\/([a-zA-Z0-9]+)[-,.]/, 1]]}" })
            end
        end

        puts "Updated quotes (#{updated_quote_ids.length.to_s}):"
        puts updated_quote_ids.join(', ')
    end

    @@emoticons = {
        Kappa: asset_path("emoticons/kappa.png"),
        PJSalt: asset_path("emoticons/pjsalt.png"),
        BrainSlug: asset_path("emoticons/brainslug.png"),
        FrankerZ: asset_path("emoticons/frankerz.png"),
        Keepo: asset_path("emoticons/keepo.png"),
        Kreygasm: asset_path("emoticons/kreygasm.png"),
        FailFish: asset_path("emoticons/failfish.png"),
        BibleThump: asset_path("emoticons/biblethump.png"),
        BabyRage: asset_path("emoticons/babyrage.png"),
        krippRage: asset_path("emoticons/kripprage.png"),
        PunchTrees: asset_path("emoticons/punchtrees.png"),
        SSSsss: asset_path("emoticons/ssssss.png"),
        MrDestructoid: asset_path("emoticons/mrdestructoid.png"),
        OpieOP: asset_path("emoticons/opieop.png"),
        krippFist: asset_path("emoticons/krippfist.png"),
        RalpherZ: asset_path("emoticons/ralpherz.png"),
        ResidentSleeper: asset_path("emoticons/residentsleeper.png"),
        DansGame: asset_path("emoticons/dansgame.png"),
        PogChamp: asset_path("emoticons/pogchamp.png"),
        SMOrc: asset_path("emoticons/smorc.png"),
        deIlluminati: asset_path("emoticons/deilluminati.png"),
        OSfrog: asset_path("emoticons/osfrog.png"),
        "4Head" => asset_path("emoticons/4head.png"),
        KappaPride: asset_path("emoticons/kappapride.png"),
        CoolCat: asset_path("emoticons/coolcat.png")
    }
end