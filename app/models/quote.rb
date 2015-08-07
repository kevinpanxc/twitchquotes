class Quote < ActiveRecord::Base
    has_many :ip_likes, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes, source: :user
    has_many :dislikes, dependent: :destroy
    has_many :dislikers, through: :dislikes, source: :user
    belongs_to :stream, foreign_key: "stream_id", primary_key: "stream_id"

	validates :quote, presence: true, length: { maximum: 1200 }
	validates :stream_id, presence: true
    validates :title, presence: true

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

    private
        def process_emoticons
            self.quote.strip!
            self.title.strip!
            Emoticons.emoticons.each do |key, value|
                self.quote = self.quote.gsub(/(?<=[^[a-zA-Z0-9_]]|^)#{key}(?=([^[a-zA-Z0-9_]]|$))/, "<img class=\"emoticon\" data-emote=\"#{key}\" src=\"#{value}\"/>")
            end
        end

        def check_profanity
            self.marked_as = ProfanityFilter.has_profanity(self.quote)
        end

        def refresh_stream_quote_count
            self.stream.quotes_count = self.stream.quotes.count
            self.stream.save
        end
end