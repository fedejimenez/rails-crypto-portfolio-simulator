class Crypto < ApplicationRecord
	include PortfoliosHelper
	include UsersHelper

	belongs_to :user
	belongs_to :portfolio, optional: true
	has_many :movements, :dependent => :destroy


	def buy(quantity)
		# self.amount_owned ||= 0
		self.amount_owned = self.amount_owned + quantity;
		movements.build(:quantity => quantity, :price => cost_per, :operation => "buy", :date => Time.now(), :portfolio_id => self.portfolio_id, :user_id => self.user_id)
		save 
	end	

	def sell(quantity)
		# self.amount_owned ||= 0
		self.amount_owned = self.amount_owned - quantity;
		movements.build(:quantity => quantity, :price => cost_per, :operation => "sell", :date => Time.now(), :portfolio_id => self.portfolio_id, :user_id => self.user_id)
		save 
	end

end
