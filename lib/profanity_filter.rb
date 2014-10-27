module ProfanityFilter
    KEY_WORDS = [
        "porn",
        "vibrator",
        "pussy",
        "milf",
        "nude",
        "cum"
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
end