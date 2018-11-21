class Like < ApplicationRecord
	belongs_to :user
	belongs_to :comment

	# Prevents users liking more than once 
	validates :user_id, uniqueness: {scope: :comment_id}
end
