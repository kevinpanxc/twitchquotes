class Quote < ActiveRecord::Base
    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes, source: :facebook_user
    has_many :dislikes, dependent: :destroy
    has_many :dislikers, through: :dislikes, source: :facebook_user
    belongs_to :stream, foreign_key: "stream_id", primary_key: "stream_id"

	validates :quote, presence: true, length: { maximum: 1200 }
	validates :stream_id, presence: true
    validates :title, presence: true

    before_save :process_quotes
    after_destroy :refresh_stream_quote_count

    def self.random
        if (c = count) != 0
            self.offset(rand(c)).first
        end
    end

    private
        def process_quotes
            Emoticons.emoticons.each do |key, value|
                self.quote = self.quote.gsub(/(?<=\s|^)#{key}(?=($|\s))/, '<img class="emoticon" src="' + value + '"/>')
            end
        end

        def refresh_stream_quote_count
            self.stream.quotes_count = self.stream.quotes.count
            self.stream.save
        end
end