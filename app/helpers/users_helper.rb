module UsersHelper
  # This will return the current user, if they exist
  # Replace with code that works with your application

  def current_user
    if session[:id]
      @current_user ||= User.find_by_id(session[:id])
    end
  end

  # Returns true if current_user exists, false otherwise
  def logged_in?
    !current_user.nil?
  end

  # a convenient method to set the session to given user's id with the `:user_id` key
  def sign_in(user)
    session[:id] = user.id
  end

  # clears the session by setting the value of `:user_id` key to `nil`
  def sign_out
    session[:id] = nil
  end
end
