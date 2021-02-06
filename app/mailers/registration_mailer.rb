class RegistrationMailer < ApplicationMailer
  default from: ENV['MAILTRAP_USERNAME']
  CONTACT_EMAIL = ENV['MAILTRAP_USERNAME']

  def submission(message)
    @message = message
    mail(to: CONTACT_EMAIL, subject: 'New registration page submission')
  end
end
