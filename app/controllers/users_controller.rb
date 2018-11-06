class UsersController < ApplicationController
  include UsersHelper

  before_action :correct_user, only: [:edit, :update, :destroy, :show]

	def new
  end

  def create
  	user = User.new(user_params)
  	if user.save
  		session[:user_id] = user.id
      flash[:success] = "User was successfully created!! Now you have U$D 10000 to start the game!!"
      sign_in(user)
      redirect_to root_path
    else
      flash[:warning] = "Oh no! There was a problem and the User was not created"
  		redirect_to '/signup'
  	end
  end

  def edit
    @user = User.find_by id: params[:id]
    # respond_to do |format|
    #   if @user.update(user_params)
    #     format.html { redirect_to @user, notice: 'Profile was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @user }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def update
    @user = User.find(current_user.id)
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(current_user.id) }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, notice: 'Error while processing the update. Please try again later.' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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
  	params.require(:user).permit(:name, :email, :avatar, :remove_avatar, :gender, :birthdate, :firstname, :lastname, :country, :password, :password_confirmation)
  end   
end
