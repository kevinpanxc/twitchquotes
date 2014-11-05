module ProfanityFilter
    KEY_WORDS = [
        "porn",
        "vibrator",
        "pussy",
        "milf",
        "nude",
        "dick",
        "╰⋃╯",
        "卐"        
    ]

    def self.set_profanity_flag(ignore_flagged)
        ActiveRecord::Base.transaction do
            # fetch quotes in batches and set marked_as integer
            Quote.find_each do |quote|
                if !ignore_flagged || quote.marked_as.nil?
                    if KEY_WORDS.any? { |word| quote.quote.downcase.include? word }
                        quote.marked_as = 1
                        quote.save
                    end
                end
            end
        end
    end

    def self.has_profanity(text)
        if KEY_WORDS.any? { |word| text.downcase.include? word }
            return 1
        else
            return nil
        end
    end

    def self.replace_with_stars(text)
        return_text = text

        KEY_WORDS.each do |word|
            while return_text =~ /#{word}/i do
                match = return_text[/#{word}/i]
                star_string = ""
                if word.length == 2
                    star_string = "#{match[0]}*"
                else
                    (word.length - 2).times do
                        star_string += "*"
                    end
                    star_string = match[0] + star_string + match[match.length - 1]
                end
                return_text.sub!(/(#{word})/i, star_string)
            end
        end

        return_text
    end

    def self.reset
        Quote.update_all("marked_as=null")
    end
end