class Stream < ActiveRecord::Base
	validates :url, presence: true
	validates :stream_id, presence: true, uniqueness: true
	validates :name, presence: true
	validates :followers, presence: true
    validates :quotes_count, presence: true, numericality: { only_integer: true }

	has_many :quotes, dependent: :destroy, foreign_key: "stream_id", primary_key: "stream_id"
end