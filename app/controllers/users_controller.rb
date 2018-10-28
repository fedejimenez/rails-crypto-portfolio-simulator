class UsersController < ApplicationController
  include UsersHelper
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

  private
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end   

end
