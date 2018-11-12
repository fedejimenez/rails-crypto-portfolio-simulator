class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery with: :exception
  helper_method :current_user
  # before_action :calculate_profit

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    redirect_to root_path unless current_user  
    flash[:warning] = "You must be logged in to see this page" unless current_user  
  end

end
