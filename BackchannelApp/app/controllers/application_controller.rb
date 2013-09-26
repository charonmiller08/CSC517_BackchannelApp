class ApplicationController < ActionController::Base
  protect_from_forgery
end

def authenticate_user
  if session[:username]
    @current_user = User.find session[:username]
    return true
  else
    redirect_to(:controller => 'sessions', :action => 'login')
    return false
  end
end

def save_login_state
  if session[:username]
    redirect_to(:controller => 'sessions', :action => 'home')
    return false
  else
    return true
  end
end