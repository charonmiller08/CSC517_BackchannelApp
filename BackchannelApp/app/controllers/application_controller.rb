class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  protected
  def is_member?
    determine_user_role
    if @member
      puts "membermemberm"
      return true
    else
      return false
    end
  end
  def is_admin?
    determine_user_role
    if @admin_user || @superadmin_user
      puts "administratorrrr"
      return true
    else
      puts "testing"
      return false
    end
  end
  def determine_user_role
    if logged_in?
      if @current_user.role == "Administrator"
        @admin_user = true
        @superadmin_user = false
        @member = false
      elsif @current_user.role == "Super Administrator"
        @superadmin_user = true
        @admin_user = false
        @member = false
      else
        @admin_user = false
        @superadmin_user = false
        @member = true
      end
    else         #else not logged in
      @admin_user = false
      @superadmin_user = false
      @member = false
    end
  end

  def logged_in?
    if session[:user_id]
      # set current user object to @current_user object variable
      @current_user = User.find session[:user_id]
      #authenticate_user_role
      return true
    else

      return false
    end
  end
  def make_user_login
    if !logged_in?
      redirect_to(:controller => 'sessions', :action => 'login')
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