class UsersController < ApplicationController
  include UsersHelper
  before_action :calculate_profit

  before_action :correct_user, only: [:edit, :update, :destroy, :following, :followers]
  before_action :update_ranking, only: [:show, :edit, :following, :followers]

  def index
  end

	def new
  end

  def show
    @user = User.find_by id: params[:id]
    @breadcrumb_title = ' PROFILE'
    @breadcrumb_icon = 'user'
    @breadcrumb_subtitle = ''
    @breadcrumb_path1 = ''
    @breadcrumb_current = 'Profile'
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "User was successfully created!! Now you have U$D 10000 to start the game!!"
      sign_in(user)
      redirect_to home_path, turbolinks: false
    else
      flash[:warning] = "Oh no! There was a problem and the User was not created"
      redirect_to root_path, turbolinks: false
    end
  end

  def edit
    @user = User.find_by id: params[:id]
    @breadcrumb_title = ' PROFILE - EDIT'
    @breadcrumb_icon = 'edit'
    @breadcrumb_subtitle = ''
    @breadcrumb_path1 = 'Profile'
    @breadcrumb_link1 = '/users/' + current_user.id.to_s
    @breadcrumb_current = 'Edit'
  end

  def update
    @user = User.find(current_user.id)
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = "User was successfully updated."
        format.html { redirect_to user_path(current_user.id) }
        format.json { render :show, status: :ok, location: @user }
      else
        flash[:warning] = 'Error while processing the update. Please try again later.' 
        format.html { render :edit}
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
  
  def correct_user
    @correct = User.find_by(id: params[:id])
    if @correct.id != current_user.id
      flash[:warning] = "Oops! You're not Authorized to view or edit this page! " 
      redirect_to user_path(current_user.id)
    end
  end

  def user_params
  	params.require(:user).permit(:name, :email, :avatar, :remove_avatar, :gender, :birthdate, :firstname, :lastname, :username, :country, :password, :password_digest)
  end   
end
