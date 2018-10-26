class UsersController < ApplicationController
	def new
  end

  def create
  	user = User.new(user_params)
  	if user.save
  		session[:user_id] = user.id
      flash[:success] = "User was successfully created!!"
      redirect_to '/'
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
