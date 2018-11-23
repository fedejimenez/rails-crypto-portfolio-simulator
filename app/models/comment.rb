class Comment < ApplicationRecord
	belongs_to :commentable, polymorphic: true
	has_many :comments, as: :commentable
	has_many :likes, dependent: :destroy
	has_many :users, through: :likes

end
