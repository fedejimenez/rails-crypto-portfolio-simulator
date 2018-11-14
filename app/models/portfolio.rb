class Portfolio < ApplicationRecord
	has_many :cryptos, :dependent => :destroy
  	after_create :default_values

	def default_values
	  	self.balance ||= 10000 
	end

	def buy(symbol, quantity)
		symbol.upcase!
		crypto = cryptos.find_or_initialize_by_symbol(symbol)
		crypto.buy(quantity)
		crypto.save
		crypto
	end

	def sell(symbol, quantity)
		symbol.upcase!
		crypto = cryptos.find_or_initialize_by_symbol(symbol)
		crypto.buy(quantity)
		crypto.save
		crypto
	end
end


