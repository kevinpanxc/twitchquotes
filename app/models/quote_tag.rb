class QuoteTag < ActiveRecord::Base
    has_many :quotes

    validates :name, presence: true, length: { maximum: 50 }
end
