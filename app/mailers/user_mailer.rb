class UserMailer < ApplicationMailer

	default from: "fjclonebnb@gmail.com"
	CONTACT_EMAIL = "fjclonebnb@gmail.com"

	def welcome_email(user_id)
	    @user = User.find(user_id)

	    # mail(   :to      => @user.email,
	    mail(   :to      => CONTACT_EMAIL,
	            :subject => "New User"
	    ) do |format|
	      # format.text
	      format.html
	    end
	end
end
