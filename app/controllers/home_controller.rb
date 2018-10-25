class HomeController < ApplicationController
  # before_action :authorize

  def index
		# if current_user
		# else 
		# 	flash[:warning] = "You must be logged in to see this page"
		# 	redirect_to '/login'
		# end

 		# TEST STAGE!!! Move to model or AJAX 
		require 'net/http'
		require 'json'
		@url = 'https://api.coinmarketcap.com/v1/ticker/?limit=20'
		@uri = URI(@url)
		@response = Net::HTTP.get(@uri)
		@coins = JSON.parse(@response) 
  end

  def about 
  end

  def lookup
 		# TEST STAGE!!! Move to model  or AJAX
  	@url = 'https://api.coinmarketcap.com/v1/ticker/?limit=50'
		@uri = URI(@url)
		@response = Net::HTTP.get(@uri)
		@lookup_coin = JSON.parse(@response) 
  	
  	@symbol = params[:sym]
  	if @symbol
  		@symbol = @symbol.upcase
  	end

  	if @symbol == ""
  		@symbol = "The search field can't be empty"
  	end
  end
end
