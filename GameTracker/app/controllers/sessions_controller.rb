class SessionsController < ApplicaitonController
  def home
  end
  
  def destroy
    session.clear
    redirect_to root_path
  end
  #don't need to define login because there's nothing that goes in it, same with home but leaving it there for reminder
end 