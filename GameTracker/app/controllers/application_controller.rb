class ApplicationController < ActionController::Base
  #give access to methods in the views
  before_action :redirect_if_not_logged_in 
  helper_method :current_user, :logged_in?, :authorized_to_edit?
  
  private   
    # check if user is in user own session
    def current_user
      @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end
    # check if user is logged in
    def logged_in?
      !!session[:user_id]
    end 
    #check if user can edit the game
    def authorized_to_edit?(game)
      game.user == current_user
    end  
    # redirect to home page
    def redirect_if_not_logged_in
      redirect_to '/' if !logged_in?  #or redirect_to login_path
    end
end
