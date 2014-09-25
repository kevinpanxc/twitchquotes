class SessionsController < ApplicationController
	def new
	end

	def create
		@error_string = ""
		user = User.find_by_email(params[:email])
		if user && user.authenticate(params[:password])
			sign_in user

			if params.has_key?(:remote) && params[:remote]
				flash[:success] = "Successfully signed in!"
	            respond_to do |format|
	                format.js
	            end
			else
				redirect_to quotes_path
			end
		else
			if !user
				@error_string = 'Invalid email'
			else
				@error_string = 'Invalid password'
			end

			if params.has_key?(:remote) && params[:remote]
	            respond_to do |format|
	                format.js
	            end
			else
				flash.now[:error] = @error_string
				render 'new'
			end
		end
	end

	def destroy
		sign_out
		redirect_to root_path
	end
end
