class ApplicationController < ActionController::Base
  protect_from_forgery


def authenticate_user
  puts("trying to authenticate")
  if session[:username]
    @current_user = User.find session[:username]
    return true
  else
    redirect_to(:controller => 'sessions', :action => 'login')
    return false
  end
end

def save_login_state
  puts "trying to save login state"
  if session[:username]
    redirect_to(:controller => 'sessions', :action => 'home')
    return false
  else
    return true
  end
end
end