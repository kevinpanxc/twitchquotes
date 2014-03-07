class Quote < ActiveRecord::Base
	validates :quote, presence: true, length: { maximum: 1200 }
	validates :stream_id, presence: true

	belongs_to :stream, foreign_key: "stream_id", primary_key: "stream_id"
end