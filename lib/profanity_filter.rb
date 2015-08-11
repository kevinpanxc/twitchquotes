module ProfanityFilter
    KEY_WORDS = [
        "porn",
        "vibrator",
        "pussy",
        "milf",
        "nude",
        "dick",
        "╰⋃╯",
        "卐",
        "autism",
        "penis",
        "jizzed",
        "rape",
        "boob",
        "erection",
        "motherfucker",
        "ejaculat",
        "queef",
        "anal"
    ]

    def self.set_profanity_flag(ignore_flagged)
        count = 0
        ActiveRecord::Base.transaction do
            # fetch quotes in batches and set marked_as integer
            Quote.find_each do |quote|
                if !ignore_flagged || !(quote.is_marked_as? :profanity_auto)
                    if KEY_WORDS.any? { |word| quote.quote.downcase.include? word }
                        count += 1
                        quote.set_marked_as(:profanity_auto)
                        quote.save
                        puts "Marked quote #{quote.id}"
                    end
                end
            end
        end
        puts "Total #{count} quotes marked for profanity."
    end

    def self.has_profanity(text)
        if KEY_WORDS.any? { |word| text.downcase.include? word }
            return true
        else
            return false
        end
    end

    def self.replace_with_stars(text)
        return_text = text

        # PERHAPS WE CAN OPTIMIZE THIS USING GSUB INSTEAD OF SUB
        KEY_WORDS.each do |word|
            while return_text =~ /#{word}/i do
                match = return_text[/#{word}/i]
                star_string = ""
                if word.length == 2
                    star_string = "#{match[0]}*"
                elsif word.length == 1
                    star_string = "*"
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