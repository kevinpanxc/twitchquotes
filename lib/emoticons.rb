class Emoticons
    def self.emoticons
        @@emoticons
    end

    def self.asset_path(path)
        ActionController::Base.helpers.asset_path(path)
    end

    def self.quotes_with_emoticons
        return Quote.where("lower(quote) like ?", "%<img class%")
    end

    def self.refactor_emoticon_quotes
        # build lower case to actual emote string
        lower_case_to_actual = build_lower_case_to_actual

        updated_quote_ids = []

        Quote.all.each do |q|
            if q.quote =~ /<img[^<>]+\/>/
                updated_quote_ids.push(q.id)
                q.update(quote: revert_img_tag_to_emoticon_string(lower_case_to_actual, q.quote))
            end
        end

        puts "Updated quotes (#{updated_quote_ids.length.to_s}):"
        puts updated_quote_ids.join(', ')
    end

    def self.build_lower_case_to_actual
        lower_case_to_actual = {}
        @@emoticons.keys.each do |key|
            lower_case_to_actual["#{key.downcase}"] = "#{key}"
        end
        return lower_case_to_actual
    end

    def self.revert_img_tag_to_emoticon_string(lower_case_to_actual, quote)
        return quote.gsub(/<img[^<>]+\/>/) { |match| "#{lower_case_to_actual[match[/\/([a-zA-Z0-9]+)[-,.]/, 1]]}" }
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
        CoolCat: asset_path("emoticons/coolcat.png"),
        trumpW: asset_path("emoticons/trumpw.png"),
        reynadTS: asset_path("emoticons/reynadts.png"),
        shazamicon: asset_path("emoticons/shazamicon.png"),
        tbSpicy: asset_path("emoticons/tbspicy.png"),
        tbSriracha: asset_path("emoticons/tbsriracha.png"),
        SwiftRage: asset_path("emoticons/swiftrage.png")
    }
end
