module ApplicationHelper
  include UsersHelper

  def get_data_from_API
    require 'net/http'
    require 'json'
    require "open-uri"
    
    url_API = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=50'

    request = headers = {
      'Accepts': 'application/json',
      'X-CMC_PRO_API_KEY': ENV['API_KEY_COINMARKETCAP']
    }

    response = HTTParty.get(url_API, headers: headers)
    @coins = response['data']
  end 

  # def get_monthly_from_API
  #   require 'net/http'
  #   require 'json'
  #   require "open-uri"
  #   @url_month = 'http://api.coindesk.com/v1/bpi/historical/close.json'
  #   @uri_month = URI(@url_month)
  #   http_month = Net::HTTP.new(@uri_month.host, @uri_month.port)
  #   http_month.use_ssl = true
  #   http_month.verify_mode = OpenSSL::SSL::VERIFY_PEER
  #   @response_month = URI.parse(@url_month).read
  #   @monthly = JSON.parse(@response_month)['bpi'] 
  #   @monthly.store(Time.now().strftime('%Y-%m-%d'), @coins.first['price_usd'] )
  # end 

  def get_historical_from_API
    require 'net/http'
    require 'json'
    require "open-uri"
    today = Time.now.strftime('%Y-%m-%d')
    
    url_historical = 'https://min-api.cryptocompare.com/data/v2/histoday?fsym=BTC&tsym=USD&limit=300'

    response = HTTParty.get(url_historical)

    # Array with data
    @historical = response['Data']['Data']
    
    # Obtain array of hashes like [{'date' => 'xxxxxxx', 'value' => 'yyyy'}]
    @values_by_date = [] 
    @historical.each do |record| 
      @values_by_date << {
                          'date' => DateTime.strptime(record['time'].to_s, '%s').strftime('%Y-%m-%d'), 
                          'value' => record['close'] 
                         }
    end
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
                @profit_array[i] += ((c['quote']['USD']["price"].to_d * crypto.amount_owned.to_d)-(crypto.cost_per.to_d * crypto.amount_owned.to_d)).round(2)
              
              end
          end
        end
      end
      if (u.portfolio.cryptos.count) == 0 && (u.portfolio.balance == 10000)
        @profit_array[i] += 0
        @array_ids.push(u.id)
      end
    end
    # Find the position of the object current_user
    if logged_in?
      position = User.all.map(&:id).index(current_user.id.to_i)
      @profit = @profit_array[position]
      if (current_user.portfolio.cryptos.count) == 0 && (current_user.portfolio.balance == 10000) 
        @profit = 0
      end
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

