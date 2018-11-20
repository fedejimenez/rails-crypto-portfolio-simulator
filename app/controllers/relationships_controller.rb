class RelationshipsController < ApplicationController
  before_action :authorize

  def create
  	@user = User.find(params[:followed_id])
    current_user.follow(@user)

    # Create Notification
    Notification.create(recipient: @user, actor: current_user, action: "follow", notifiable: @user)

    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
  	@user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)

    # Create Notification
    Notification.create(recipient: @user, actor: current_user, action: "unfollow", notifiable: @user)

    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
