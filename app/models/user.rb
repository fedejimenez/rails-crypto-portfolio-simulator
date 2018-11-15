class User < ApplicationRecord
	has_secure_password
	has_many :cryptos
	has_one :portfolio, dependent: :destroy
	has_one :movements, dependent: :destroy
  	has_many :authentications, dependent: :destroy
	after_create :create_portfolio
	after_create :send_email

	# Validatons
	before_save { |user| user.email = email.downcase }
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	validates :username, length: {maximum: 70}, uniqueness: {case_sensitive: true}
	validates :email, presence: true,
			  format: { with: VALID_EMAIL_REGEX },
			  uniqueness: { case_sensitive: false }
	validates :password_digest, presence: true, length: { minimum: 4 }

	# Avatar image
	mount_uploader :avatar, AvatarUploader # Create uploader

	def self.create_with_auth_and_hash(authentication, auth_hash)
		user = self.create!(
			name: auth_hash["info"]["name"],
			email: auth_hash["info"]["email"],
			password: SecureRandom.hex(10)
		)
		user.authentications << authentication
		return user
	end

	# grab google to access google for user data
	def google_token
		x = self.authentications.find_by(provider: 'google_oauth2')
		return x.token unless x.nil?
	end

	# grab facebook to access facebook for user data
	def fb_token
		x = self.authentications.where(:provider => :facebook).first
		return x.token unless x.nil?
	end

	# Create Portfolio after sign up
	def create_portfolio
	  @user = User.last
	  @portfolio = Portfolio.new
	  @user.portfolio = @portfolio
	  @user.save
	  @portfolio.save
	end

	# Send welcome email
	def send_email()
		@user = User.last
		mail = UserMailer.welcome_email(@user.id)
		# mail.deliver_now
		mail.deliver_later
        # UserJob.perform_later(@user.id)
	end
end
