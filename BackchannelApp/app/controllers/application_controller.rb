class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_filter :logged_in?, :except => [:logged_in?, :save_login_state]

  helper_method :is_admin?
  helper_method :is_member?
  helper_method :logged_in?

  before_filter :is_current_page_home?
  protected
  def is_current_page_home?
    puts "url_home"
    puts request.url
    if request.url == "http://127.0.0.1:3000/"
      @home = true
    end
  end
  def is_member?
    determine_user_role

  end
  def is_admin?
    determine_user_role
    if @admin_user || @superadmin_user
      return true
    else
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
      if !is_admin?
      redirect_to(:controller => 'sessions', :action => 'home')
      end
      return false
    else
      return true
    end
  end
end