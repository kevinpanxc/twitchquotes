class EmoticonUtils
    def self.asset_path(path)
        ActionController::Base.helpers.asset_path(path)
    end

    def self.quotes_with_emoticons
        return Quote.where("lower(quote) like ?", "%<img class%")
    end

    def self.refactor_emoticon_quotes
        updated_quote_ids = []

        Quote.all.each do |q|
            if q.quote =~ /<img[^<>]+\/>/
                updated_quote_ids.push(q.id)
                q.save
            end
        end

        puts "Updated quotes (#{updated_quote_ids.length.to_s}):"
        puts updated_quote_ids.join(', ')
    end

    def self.revert_img_tag_to_emoticon_string(quote)
        # e.g. <img class="emoticon" data-emote="MingLee" src="/assets/emoticons/minglee-37bd3a8f07cab6f5fecf73a4aae076b234e34e1adcfcd3329f1646becebfc35d.png"/>
        # match[/\/([a-zA-Z0-9]+)[-,.]/, 1] returns minglee
        # return quote.gsub(/<img[^<>]+\/>/) { |match| "#{lower_case_to_actual[match[/\/([a-zA-Z0-9]+)[-,.]/, 1]]}" }

        # this new version just looks for the text in data-emote
        return quote.gsub(/<img[^<>]+\/>/) { |match| "#{match[/data-emote=\"([a-zA-Z0-9]+)\"/, 1]}" }
    end

    def self.emoticon_string_to_img_tag(quote)
        Emoticon.all.each do |emoticon|
            if not emoticon.is_marked_as?(:default_robot)
                quote = quote.gsub(/(?<=[^[a-zA-Z0-9_]]|^)#{emoticon.string_id}(?=([^[a-zA-Z0-9_]]|$))/, "<img class=\"emoticon\" data-emote=\"#{emoticon.string_id}\" src=\"#{emoticon.image_url}\"/>")
            end
        end
        return quote
    end

    # TODO: this method can be optimized like crazy
    def self.build_global_emoticons_dataset
        Emoticon.update_all(in_use: false)

        global_emoticons = TwitchApi.fetch_global_emoticons["emoticons"]

        global_emoticons.each do |emoticon|
            if Emoticon.where(string_id: emoticon["regex"]).blank?
                marked_as = Emoticon.get_marked_as()[:global]
                if emoticon["regex"].include? "\\"
                    marked_as |= Emoticon.get_marked_as()[:default_robot]
                end
                Emoticon.create!(string_id: emoticon["regex"], image_url: emoticon["url"], marked_as: marked_as, in_use: true)
            else
                emoticon = Emoticon.find_by_string_id(emoticon["regex"])
                emoticon.update!(in_use: true)
            end
        end
    end

    EMOTICONS = {
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
        SwiftRage: asset_path("emoticons/swiftrage.png"),
        OSkomodo: asset_path("emoticons/oskomodo.png"),
        MingLee: asset_path("emoticons/minglee.png"),
        EleGiggle: asset_path("emoticons/elegiggle.png"),
        KKona: asset_path("emoticons/kkona.png"),
        KappaRoss: asset_path("emoticons/kappaross.png")
    }.freeze
end
