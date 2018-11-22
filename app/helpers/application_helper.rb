module ApplicationHelper
  include UsersHelper

  def get_data_from_API
    require 'net/http'
    require 'json'
    require "open-uri"
    @url_API = 'https://api.coinmarketcap.com/v1/ticker/?limit=50'
    @uri_API = URI(@url_API)
    http_API = Net::HTTP.new(@uri_API.host, @uri_API.port)
    http_API.use_ssl = true
    http_API.verify_mode = OpenSSL::SSL::VERIFY_PEER
    @response_API = Net::HTTP.get(@uri_API)
    @coins = JSON.parse(@response_API) 
  end 

  def get_monthly_from_API
    require 'net/http'
    require 'json'
    require "open-uri"
    @url_month = 'http://api.coindesk.com/v1/bpi/historical/close.json'
    @uri_month = URI(@url_month)
    http_month = Net::HTTP.new(@uri_month.host, @uri_month.port)
    http_month.use_ssl = true
    http_month.verify_mode = OpenSSL::SSL::VERIFY_PEER
    @response_month = URI.parse(@url_month).read
    @monthly = JSON.parse(@response_month)['bpi'] 
    @monthly.store(Time.now().strftime('%Y-%m-%d'), @coins.first['price_usd'] )
  end 

  def get_historical_from_API
    require 'net/http'
    require 'json'
    require "open-uri"
    today = Time.now.strftime('%Y-%m-%d')
    @url_hist = 'https://api.coindesk.com/v1/bpi/historical/close.json?start=2015-09-01&end='+today
    @uri_hist = URI(@url_hist)
    http_hist = Net::HTTP.new(@uri_hist.host, @uri_hist.port)
    http_hist.use_ssl = true
    http_hist.verify_mode = OpenSSL::SSL::VERIFY_PEER
    @response_hist = URI.parse(@url_hist).read
    @historical = JSON.parse(@response_hist)['bpi'] 
    # Array with data
    @historical.store(Time.now().strftime('%Y-%m-%d'), @coins.first['price_usd'] )
    # Obtain array of hashes 
    key_value = @historical.map do |key, value| 
      [key, value]
    end
    @array_of_hashes = [] 
    key_value.each { |record| @array_of_hashes << {'date' => record[0], 'value' => record[1].to_i }} 
  end 

  def calculate_profit
    get_data_from_API
    @initial_amount = 10000
    @cryptos = Crypto.all
    @profit = 0
    @array_ids = []
    @crypto_names = []
    @profit_array = User.all.length.times.collect{|i| 0}
    
    User.all.each_with_index do |u,i|
      @cryptos.each do |crypto|
        if (u.id.to_i == crypto.user_id.to_i)
          for c in @coins 
              if crypto.symbol == c["symbol"] 
                # Save crypto names
                @crypto_names[crypto.id] = c["name"] 
              	# Save array with user id's
              	@array_ids.push(u.id)
                # Calculate all the profits for all users
                @profit_array[i] += ((c["price_usd"].to_d * crypto.amount_owned.to_d)-(crypto.cost_per.to_d * crypto.amount_owned.to_d)).round(2)
              end
          end
        end
      end
    end
    # Find the position of the object current_user
    if logged_in?
      position = User.all.map(&:id).index(current_user.id.to_i)
      @profit = @profit_array[position]
    end

    return @profit, @profit_array
  end

  def update_ranking
    @length = Array(1..User.all.length)
    @hash_profit = Hash[@array_ids.uniq.zip(@profit_array)]
  	@hash_ranking = @hash_profit.sort_by {|k,v| -v}.to_h

    # Update current user position
    if logged_in?
	   @rank = @hash_ranking.find_index { |k,_| k== current_user.id } + 1 
    end
  end

  def find_icon(icon)
    icons = ["ada","bat","bch","bcn", "bnb", "btc","btg", "btm","bts", "dash","dcr",
    	"dgb","doge","eos","etc","eth","icx","lsk","ltc","miota","nano","neo","omg","ppt",
      "qtum","sc","trx","usdt","waves","xem","xlm","xmr", "xrp","xtz", "xvg", "zec"]

    if icons.include?(icon)
      return "https://cryptospaniards.com/simulator/static/coins/#{icon}.png"
    else
      return "https://www.glyphicons.com/img/glyphicons/basic/2x/glyphicons-basic-227-dollar@2x.png"
    end
  end

  def coin_name_by_symbol(symbol)
    for c in @coins
      if c['symbol'] == symbol
        @coin_name = c["name"]
        return @coin_name
      end
    end
  end


end

