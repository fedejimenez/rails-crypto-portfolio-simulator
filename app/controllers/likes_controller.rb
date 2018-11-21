class LikesController < ApplicationController

	def like
		@user = User.find(params[:user_id])
		@comment = Comment.find(params[:comment_id])
		@user.like!(@comment, @user)
		respond_to do |format|
  			format.js 
		end
	end

	def dislike
		@user = User.find(params[:user_id])
		@like = @user.likes.find_by_comment_id(params[:comment_id])
		@comment = Comment.find(params[:comment_id])
		@like.destroy!
		respond_to do |format|
  			format.js 
		end
	end

end
