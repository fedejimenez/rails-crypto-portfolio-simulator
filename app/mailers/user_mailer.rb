class UserMailer < ApplicationMailer
def welcome_email(user_id)
    @user = User.find(user_id)

    mail(   :to      => @user.email,
            :subject => "New User"
    ) do |format|
      format.text
      format.html
    end
  end
end
end
