class ApplicationController < ActionController::Base
  protect_from_forgery
def get_user_type

end

def authenticate_user
  if session[:username]
    @current_user = User.find_by_username(session[:username])
    if @current_user
      return true
    else
      return false
    end
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
end