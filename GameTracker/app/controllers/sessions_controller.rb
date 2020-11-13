class SessionsController < ApplicaitonController
  #don't need to define login because there's nothing that goes in it, same with home but leaving it there for reminder
  def home
    
  end
  
  def destroy
    session.clear
    redirect_to root_path
  end

  
  def create
    user = User.find_by(username: params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to user_path(user) #or "/users/#{user.id} for long form"
    else 
      flash[:message] = "Incorrect login information."
      redirect_to "/login"
    end
  end
  
end 