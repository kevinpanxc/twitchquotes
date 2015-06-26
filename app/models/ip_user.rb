class IpUser < ActiveRecord::Base
    validates :ip_address, presence: true, format: { with: Regexp.union(Resolv::IPv4::Regex, Resolv::IPv6::Regex) },
                uniqueness: true
    has_many :ip_likes, dependent: :destroy
    has_many :ip_liked_quotes, through: :ip_likes, source: :quote
end
