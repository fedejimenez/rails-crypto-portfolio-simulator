class HomeController < ApplicationController
  before_action :authorize

  def index
		if current_user
		else 
			flash[:warning] = "You must be logged in to see this page"
			redirect_to '/login'
		end
  end

  def about 
  end
end
