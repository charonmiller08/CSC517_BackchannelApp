class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  protected
  def authenticate_user
    if session[:user_id]
      # set current user object to @current_user object variable
      @current_user = User.find session[:user_id]
      return true
    else
      redirect_to(:controller => 'sessions', :action => 'login')
      return false
    end
  end

  def authenticate_user_role
    if @current_user
      if @current_user.role == "Administrator" || @current_user.role == "Super Administrator"
        @admin_user = true
        return true
      else
        @admin_user = false
        redirect_back_or home_url
        return false
      end
    else
      @admin_user = false
      return true
    end
  end

  def save_login_state
    if session[:user_id]
      redirect_to(:controller => 'static_pages', :action => 'home')
      return false
    else
      return true
    end
  end
end