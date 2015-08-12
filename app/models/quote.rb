class Quote < ActiveRecord::Base
    MarkedAs = {
        none: 0,
        profanity_auto: 1,
        user_override: 2,
        dont_filter_title: 4,
        no_emote: 8
    }

    has_many :ip_likes, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes, source: :user
    has_many :dislikes, dependent: :destroy
    has_many :dislikers, through: :dislikes, source: :user
    belongs_to :stream, foreign_key: "stream_id", primary_key: "stream_id"

	validates :quote, presence: true, length: { maximum: 1200 }
	validates :stream_id, presence: true
    validates :title, presence: true
    validates :marked_as, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    before_create :generate_f_ip_likes
    before_save :process_emoticons
    before_save :check_profanity
    after_destroy :refresh_stream_quote_count

    def self.random
        if (c = count) != 0
            self.offset(rand(c)).first
        end
    end

    def generate_f_ip_likes
        gen = Rubystats::NormalDistribution.new(10, 5)
        self.f_ip_likes = gen.rng.ceil.abs
    end

    def set_marked_as(type)
        if MarkedAs.has_key? type
            self.marked_as |= MarkedAs[type]
        end
    end

    def remove_marked_as(type)
        if MarkedAs.has_key? type
            self.marked_as &= ~MarkedAs[type]
        end
    end

    def is_marked_as?(type)
        if MarkedAs.has_key? type
            return self.marked_as & MarkedAs[type] != 0
        else
            return false
        end
    end

    def not_marked_as?
        return self.marked_as == 0
    end

    private
        def process_emoticons
            if !self.is_marked_as? :no_emote
                self.quote.strip!
                self.title.strip!
                self.quote = Emoticons.revert_img_tag_to_emoticon_string(Emoticons.build_lower_case_to_actual, self.quote)
                Emoticons.emoticons.each do |key, value|
                    self.quote = self.quote.gsub(/(?<=[^[a-zA-Z0-9_]]|^)#{key}(?=([^[a-zA-Z0-9_]]|$))/, "<img class=\"emoticon\" data-emote=\"#{key}\" src=\"#{value}\"/>")
                end
            end
        end

        def check_profanity
            if ProfanityFilter.has_profanity(self.quote)
                set_marked_as(:profanity_auto)
            else
                remove_marked_as(:profanity_auto)
            end
        end

        def refresh_stream_quote_count
            self.stream.quotes_count = self.stream.quotes.count
            self.stream.save
        end
end