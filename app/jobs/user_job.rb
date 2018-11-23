class UserJob < ActiveJob::Base  
  queue_as :default

  def perform(user_id)
    UserMailer.welcome_email(user_id).deliver_later
  end

end