class IpLike < ActiveRecord::Base
    belongs_to :ip_user
    belongs_to :quote

    validates :ip_user_id, presence: true
    validates :quote_id, presence: true
end
