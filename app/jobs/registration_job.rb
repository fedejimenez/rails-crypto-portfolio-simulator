class RegistrationJob < ApplicationJob
  queue_as :default

  def perform(email_message)
    # Do something later
    RegistrationMailer.submission(email_message).deliver
  end
end
