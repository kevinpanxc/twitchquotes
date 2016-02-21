class IpUser < ActiveRecord::Base
    MAX_SUBMISSIONS_PER_DAY = 5

    has_many :ip_likes, dependent: :destroy
    has_many :ip_liked_quotes, through: :ip_likes, source: :quote
    has_many :submissions

    validates :ip_address, presence: true, format: { with: Regexp.union(Resolv::IPv4::Regex, Resolv::IPv6::Regex) },
                uniqueness: true
end
