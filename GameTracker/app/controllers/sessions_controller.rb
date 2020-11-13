class SessionsController < ApplicaitonController
  #don't need to define login because there's nothing that goes in it, same with home but leaving it there for reminder
  def home
    
  end
  
  def destroy
    session.clear
    redirect_to root_path
  end

  def create
    if params[:provider] == 'google'
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
  
  def omniauth
    @user = User.create_by_google_omniauth(auth)
  
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end
  
  private
  
  def auth
    request.env['omniauth.auth']
  end
   
  
end 