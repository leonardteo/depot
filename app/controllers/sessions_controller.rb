# Controls authentication in the app
class SessionsController < ApplicationController
  
  skip_before_filter :authorize
  
  def new
    
  end

  #Creates a new session
  def create
    user = User.find_by_name(params[:name])
    if (user and user.authenticate(params[:password]))
      session[:user_id] = user.id
      redirect_to admin_url
    else
      redirect_to login_url, :alert => "Invalid user/password combination"
    end
  end

  #Log a user out
  def destroy
    session[:user_id] = nil
    redirect_to store_url, :notice => "Logged out"
  end

end
