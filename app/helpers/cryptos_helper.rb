module CryptosHelper
	def get_data_from_API
		require 'net/http'
		require 'json'
	    @url = 'https://api.coinmarketcap.com/v1/ticker/?limit=50'
	    @uri = URI(@url)
	    @response = Net::HTTP.get(@uri)
	    @coins = JSON.parse(@response) 
	    @balance = 0
  end	

  def current_coin(symbol)
  	get_data_from_API
 		for c in @coins
      if symbol == c["symbol"]
      	return c
      end
  	end
  end
end
