class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    #log in and redirect to the show page
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
  end
  
  def show
  end  
  
  private
    
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
