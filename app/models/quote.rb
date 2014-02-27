class Quote < ActiveRecord::Base
	validates :quote, presence: true
	validates :stream_url, presence: true
	validates :stream_id, presence: true
	validates :stream_name, presence: true

	belongs_to :stream, foreign_key: "stream_id", primary_key: "stream_id"
end