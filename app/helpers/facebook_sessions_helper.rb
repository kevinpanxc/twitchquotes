module FacebookSessionsHelper
    def current_facebook_user
        @current_facebook_user ||= FacebookUser.find(session[:user_id]) if session[:user_id]
    end
end