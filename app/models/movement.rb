class Movement < ApplicationRecord
	belongs_to :crypto
	belongs_to :portfolio
  belongs_to :user
end

