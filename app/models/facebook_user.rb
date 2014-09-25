class FacebookUser < ActiveRecord::Base
    def self.from_omniauth(auth)
        where(auth.slice(:provider, :uid)).first_or_initialize.tap do |facebook_user|
            facebook_user.provider = auth.provider
            facebook_user.uid = auth.uid
            facebook_user.name = auth.info.name
            facebook_user.oauth_token = auth.credentials.token
            facebook_user.oauth_expires_at = Time.at(auth.credentials.expires_at)
            facebook_user.save!
        end
    end
end
