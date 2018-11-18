class CommentsController < ApplicationController
before_action :find_commentable

    def index
      @comments = Comment.all
    end
    def new
      @comment = Comment.new
    end

    def create
      @comment = @commentable.comments.new comment_params
      @comment.user_id = current_user.id

      if @comment.save
        redirect_to '/home/suggestions', notice: 'Your comment was successfully posted!'
      else
        redirect_to '/home/suggestions', notice: "Your comment wasn't posted!"
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:body, :user_id)
    end

    def find_commentable
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      @commentable = User.find_by_id(params[:user_id]) if params[:user_id]
    end
end