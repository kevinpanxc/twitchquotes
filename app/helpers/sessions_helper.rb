module SessionsHelper
	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
	end

	def signed_in?
		!current_user.nil?
	end

	def create_current_ip_user
        ip_user = IpUser.new(ip_address: request.remote_ip)
        if ip_user.save
            self.current_user = ip_user
        end
	end

	def current_ip_user=(ip_user)
		@ip_user = ip_user
	end

	def current_ip_user
		puts 'three two one!'
		puts @ip_user

		if @ip_user.nil?
			if IpUser.exists?(ip_address: request.remote_ip)
				@ip_user = IpUser.find_by(ip_address: request.remote_ip)
			end
		end

		@ip_user
	end

	def signed_in_user
		unless signed_in?
			redirect_to signin_path, notice: "Please sign in."
		end
	end

	def signed_in_user_open_modal
		unless signed_in?
			render "sessions/sign_in_notification"
		end
	end

	def is_admin
		unless current_user and current_user.admin?
			redirect_to signin_path, notice: "Not authorized."
		end
	end
end
