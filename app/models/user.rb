class User < ActiveRecord::Base
    has_many :likes, dependent: :destroy
    has_many :liked_quotes, through: :likes, source: :quote
    has_many :dislikes, dependent: :destroy
    has_many :disliked_quotes, through: :dislikes, source: :quote
	
	has_secure_password

	VALID_USERNAME_REGEX = /\A[a-z0-9\-_]+\z/i
	validates :username, presence: true, length: { maximum: 24 },
				format: { with: VALID_USERNAME_REGEX },
				uniqueness: { case_sensitive: false }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, 
				format: { with: VALID_EMAIL_REGEX }, 
				uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 } # BCrypt adds a password presence validation on default. Adding one here creates two similar error messages when the password field is empty on submission
	validates :password_confirmation, presence: true

	# to ensure that non unique emails are also caught at the database level
	# see migration: add_index_to_users_email
	before_save { |user| user.email = email.downcase }
	before_save :create_remember_token

	private
		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end
end
