class Crypto < ApplicationRecord
	include PortfoliosHelper
	include UsersHelper

	belongs_to :user
	belongs_to :portfolio, optional: true
	has_many :movements, :dependent => :destroy


	def buy(quantity)
		movements.build(:quantity => last_transaction, :price => cost_per, :operation => "buy", :date => Time.now(), :portfolio_id => self.portfolio_id, :user_id => self.user_id)
		save 
	end	

	def sell(quantity)
		movements.build(:quantity => amount_owned, :price => cost_per, :operation => "sell", :date => Time.now(), :portfolio_id => self.portfolio_id, :user_id => self.user_id)
		save 
	end

end
