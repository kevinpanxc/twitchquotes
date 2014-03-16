class Dislike < ActiveRecord::Base
  belongs_to :facebook_user
  belongs_to :quote

  validates :facebook_user_id, presence: true
  validates :quote_id, presence: true
end