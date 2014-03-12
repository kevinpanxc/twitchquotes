class Quote < ActiveRecord::Base
	validates :quote, presence: true, length: { maximum: 1200 }
	validates :stream_id, presence: true

	belongs_to :stream, foreign_key: "stream_id", primary_key: "stream_id"

    before_save :process_quotes

    private
        def process_quotes
            Emoticons.emoticons.each do |key, value|
                self.quote = self.quote.gsub(/(?<=\s|^)#{key}(?=($|\s))/, '<img src="' + value + '"/>')
            end
        end
end