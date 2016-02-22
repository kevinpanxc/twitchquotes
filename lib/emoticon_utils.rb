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
                quote = quote.gsub(/(?<=[^[a-zA-Z0-9_]]|^)#{emoticon.string_id}(?=([^[a-zA-Z0-9_]]|$))/, "<img class=\"emoticon\" data-emote=\"#{emoticon.string_id}\" src=\"#{emoticon.get_image_url}\"/>")
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

    EMOTICONS_IP_LIKE_BEFORE = [ 
        "kappa", 
        "keepo", 
        "kappaclaus", 
        "kappaross" ].freeze

    EMOTICONS_IP_LIKE_AFTER = [
        "frankerz",
        "pogchamp",
        "elegiggle",
        "4head",
        "kreygasm"
        ].freeze

    EMOTICONS = {
        BibleThump: asset_path("emoticons/biblethump.png")
    }.freeze
end
