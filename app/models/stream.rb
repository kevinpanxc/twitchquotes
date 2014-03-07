class Stream < ActiveRecord::Base
	validates :url, presence: true
	validates :stream_id, presence: true, uniqueness: true
	validates :name, presence: true
	validates :followers, presence: true

	has_many :quotes, dependent: :destroy, foreign_key: "stream_id", primary_key: "stream_id"
end