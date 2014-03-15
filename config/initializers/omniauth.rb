OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['TQ_FACEBOOK_APP_ID'], ENV['TQ_FACEBOOK_APP_SECRET']
end