class UsersController < ApplicationController
  skip_before_action :redirect_if_not_logged_in, only: [:new, :create]
  # make new user
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    #log in and redirect to the show page
    if @user.valid? # validates user and save
      @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end
  # check if user is logged in, if not redirect to home page
  def show
    redirect_if_not_logged_in
    @user = User.find_by_id(params[:id])
    redirect_to '/' if !@user
  end  
  
  private
  # parameter for user
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
