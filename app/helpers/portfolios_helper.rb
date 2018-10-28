module PortfoliosHelper
  include UsersHelper

  def current_portfolio
  	if current_user
     @current_portfolio ||= Portfolio.where(user_id: current_user.id).first
 	end
  end
end
