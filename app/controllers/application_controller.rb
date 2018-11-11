class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :calculate_profit

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    redirect_to root_path unless current_user  
    flash[:warning] = "You must be logged in to see this page" unless current_user  
  end

  def calculate_profit
  	@initial_amount = 10000
  	@cryptos = Crypto.all
    get_data_from_API
    get_historical_from_API
    @profit = 0
  	 @cryptos.each do |crypto| 
       if (crypto.user_id == current_user.id)  && (crypto.amount_owned != 0)
           for c in @coins 
             if crypto.symbol == c["symbol"] 
               @profit += ((c["price_usd"].to_d * crypto.amount_owned.to_d)-(crypto.cost_per.to_d * crypto.amount_owned.to_d)).round(2)
            end
          end 
      end
  	end
  	return @profit
  end

  def get_data_from_API
    require 'net/http'
    require 'json'
      @url = 'https://api.coinmarketcap.com/v1/ticker/?limit=50'
      @uri = URI(@url)
      @response = Net::HTTP.get(@uri)
      @coins = JSON.parse(@response) 
  end 

  def get_historical_from_API
		require 'net/http'
		require 'json'
	    @url = 'https://api.coindesk.com/v1/bpi/historical/close.json'
	    @uri = URI(@url)
	    @response = Net::HTTP.get(@uri)
	    @historical = JSON.parse(@response)['bpi'] 
  end	
end
