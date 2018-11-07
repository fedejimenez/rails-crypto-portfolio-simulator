class User < ApplicationRecord
	has_secure_password
	has_many :cryptos
	has_one :portfolio, dependent: :destroy
  	has_many :authentications, dependent: :destroy
	after_create :create_portfolio

	# Validatons
	before_save { |user| user.email = email.downcase }
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	validates :name, length: {maximum: 70}, presence: true
	validates :email, presence: true,
			  format: { with: VALID_EMAIL_REGEX },
			  uniqueness: { case_sensitive: false }
			  
	# validates :gender, presence: true
	# validates :country, presence: true
	# validates :birthdate, presence: true
	
	# validates :encrypted_password, presence: true, length: { minimum: 6 }

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

	# Create Portfolio after sign up

	def create_portfolio
	  @user = User.last
	  @portfolio = Portfolio.new
	  @user.portfolio = @portfolio
	  @user.save
	  @portfolio.save
	end
end
