class Quote < ActiveRecord::Base
    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes, source: :facebook_user
    has_many :dislikes, dependent: :destroy
    has_many :dislikers, through: :dislikes, source: :facebook_user

	validates :quote, presence: true, length: { maximum: 1200 }
	validates :stream_id, presence: true

	belongs_to :stream, foreign_key: "stream_id", primary_key: "stream_id"

    before_save :process_quotes

    private
        def process_quotes
            Emoticons.emoticons.each do |key, value|
                self.quote = self.quote.gsub(/(?<=\s|^)#{key}(?=($|\s))/, '<img class="emoticon" src="' + value + '"/>')
            end
        end
end