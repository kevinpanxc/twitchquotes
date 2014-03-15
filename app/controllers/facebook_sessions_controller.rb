class FacebookSessionsController < ApplicationController
  def create
    facebook_user = FacebookUser.from_omniauth(env["omniauth.auth"])
    session[:user_id] = facebook_user.id
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end