module FacebookSessionsHelper
    def current_facebook_user
        @current_facebook_user ||= FacebookUser.find(session[:user_id]) if session[:user_id]
    end

    def facebook_signed_in?
        !current_facebook_user.nil?
    end

    def require_facebook_sign_in
        if !facebook_signed_in?
            render "facebook_sessions/sign_in_notification"
        end
    end
end