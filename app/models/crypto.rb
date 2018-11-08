class Crypto < ApplicationRecord
	include PortfoliosHelper
	include UsersHelper

	belongs_to :user
	belongs_to :portfolio, optional: true
	has_many :movements, :dependent => :destroy
	before_save :charge_fee


	def buy(quantity)
		movements.build(:quantity => last_transaction, :price => (cost_per.to_d * 1.001), :operation => "buy", :date => Time.now(), :portfolio_id => self.portfolio_id, :user_id => self.user_id)
		save 
	end	

	def sell(quantity)
		movements.build(:quantity => last_transaction, :price => (cost_per.to_d * 0.999), :operation => "sell", :date => Time.now(), :portfolio_id => self.portfolio_id, :user_id => self.user_id)
		save 
	end

	def charge_fee
		if self[:last_action] == "Sell"
			self.cost_per = self[:cost_per].to_d * 0.999 
		elsif self[:last_action]== "Buy"
			self.cost_per = self[:cost_per].to_d * 1.001 
		end
	end

end
