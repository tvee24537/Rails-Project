class SessionsController < ApplicationController
  skip_before_action :redirect_if_not_logged_in
  #don't need to define login because there's nothing that goes in it, same with home but leaving it there for reminder
  def home
    
  end
  # clear session, done after logout
  def destroy
    session.clear
    redirect_to '/'
  end
  # Omniauth for google
  def create
    if params[:provider] == 'google_oauth2'
      @user = User.create_by_google_omniauth(auth)
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      @user = User.find_by(username: params[:user][:username])
      if @user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id 
        redirect_to user_path(@user)
      else
        flash[:error] = "Your login information was incorrect. Please try again."
        redirect_to login_path
      end
    end
  end
  # give user created by google auth a session and redirect to user home page
  def omniauth
    @user = User.create_by_google_omniauth(auth)
  
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end
  
  private
  # get data from env file
  def auth
    request.env['omniauth.auth']
  end
   
  
end 