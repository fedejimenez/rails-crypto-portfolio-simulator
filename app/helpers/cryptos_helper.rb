module CryptosHelper
	def get_data_from_API
		require 'net/http'
		require 'json'
	    @url = 'https://api.coinmarketcap.com/v1/ticker/?limit=50'
	    @uri = URI(@url)
	    @response = Net::HTTP.get(@uri)
	    @coins = JSON.parse(@response) 

	    @profit = 0
  	end	

  def current_coin(symbol)
  	get_data_from_API
 		for c in @coins
      		if symbol == c["symbol"]
      	return c
      end
  	end
  end

  def calculate_profit
  	 @cryptos.each do |crypto| 
       if crypto.user_id == current_user.id 
           for c in @coins 
             if crypto.symbol == c["symbol"] 
               @profit += (c["price_usd"].to_i * crypto.amount_owned.to_i)-(crypto.cost_per * crypto.amount_owned)
            end
          end 
      end
  	end
  	return @profit
  end
end
