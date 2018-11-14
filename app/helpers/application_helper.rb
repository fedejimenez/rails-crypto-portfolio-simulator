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

  def get_historical_from_API
    require 'net/http'
    require 'json'
    require "open-uri"
    @url_hist = 'http://api.coindesk.com/v1/bpi/historical/close.json'
    @uri_hist = URI(@url_hist)
    http_hist = Net::HTTP.new(@uri_hist.host, @uri_hist.port)
    http_hist.use_ssl = true
    http_hist.verify_mode = OpenSSL::SSL::VERIFY_PEER
    @response_hist = URI.parse(@url_hist).read
    # @response_hist = Net::HTTP.get(@uri_hist)
    @historical = JSON.parse(@response_hist)['bpi'] 
  end 

  def calculate_profit
    get_data_from_API
    @initial_amount = 10000
    @cryptos = Crypto.all
    @profit = 0
    @array_ids = []
    @profit_array = User.all.length.times.collect{|i| 0}
    
    User.all.each_with_index do |u,i|
      @cryptos.each do |crypto|
        if (u.id.to_i == crypto.user_id.to_i)
          for c in @coins 
              if crypto.symbol == c["symbol"] 
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

    update_ranking
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
    icons = ["adc","aeo","amp","anc","ard","aur","bay","bcn","brk","brx","bsd","bta","btc","bts","das","dcr",
    	"dgb","dgd","dgx","dmd","emc","erc","etc","eth","fct","flo","frk","ftc","gld","gnt","btc-alt",
    	"cloak","btcd","clam","doge","game","heat","incnt","kore","kobo","ldoge","grc","grs","icn","ifc",
    	"ioc","kmd","lbc","lsk","ltc","mue","nlg","nmc","nuc","nxt","maid","mint","mona","neos","note",
    	"ok","omni","pink","pivx","pot","ppc","qrk","rby","rdd","rep","rise","sjcx","sls","steem","strat",
    	"sys","trig","ubq","unity","usdt","vrc","vtc","waves","xcp","xem","xmr","xrp","zec"]

    if icons.include?(icon)
      return "cf cf-#{icon}"
    else
      return "glyphicon glyphicon-usd"
    end
  end

end

