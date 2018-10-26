class HomeController < ApplicationController
  # before_action :authorize
  include CryptosHelper

  def index
    get_data_from_API
  end

  def about 
  end

  def lookup
    get_data_from_API
  	@symbol = params[:sym].upcase
  	if @symbol == ""
  		@symbol = "The search field can't be empty"
  	end
  end
end
