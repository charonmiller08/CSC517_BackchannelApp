class ApplicationController < ActionController::Base
  protect_from_forgery

  #This includes the session helper methods which allows the application controller and all other controllers to use
  # the stored_location method and redirect_back_or(default) methods which are used to redirect an unauthorized user
  # back to where they came from
  include SessionsHelper

  #Run this method before every controller call to check if the user is logged in
  before_filter :logged_in?, :except => [:logged_in?, :save_login_state]
  #Run this method before every controller call to see if it is the home page so
  # you can know whether to show the home page link
  before_filter :is_current_page_home?

  #These methods are made available to the views to validate authorization of the user for certain views
  helper_method :is_admin?
  helper_method :is_member?
  helper_method :logged_in?
  helper_method :is_my_post?



  protected
  #is_my_post? returns true if the userid  parameter is the same as the current_user's user id
  #so that only certain views or parameters are shown for that post only if it is yours or not yours
  def is_my_post?(userid)
    #if someone is logged in
    if @current_user
      #if the user id of the post is the user id of the person logged in => it is my post
      if @current_user.id == userid
        return true
      # it isn't my post
      else
        return false
      end
    #It isn't my post because I'm not logged in
    else
      return false
    end
  end

  #This simply checks to see if the current page is home,
  # and if it is don't put the link to the Home page
  def is_current_page_home?
    puts "url_home"
    puts request.url
    if request.url == "http://127.0.0.1:3000/" #home url
      @home = true
    end
  end

  #This checks to see if the current user is a member
  def is_member?
    determine_user_role
  end

  #This checks to see if the current user is an administrator or super administrator
  def is_admin?
    determine_user_role
    if @admin_user || @superadmin_user
      return true
    else
      return false
    end
  end

  #This stores the current user role into a variable which can be used in other methods to determine
  #level of authority
  def determine_user_role
    if logged_in? #Then you are a member and you have a role
      if @current_user.role == "Administrator"
        @admin_user = true
        @superadmin_user = false
        @member = false
      elsif @current_user.role == "Super Administrator"
        @superadmin_user = true
        @admin_user = false
        @member = false
      #You are a member
      else
        @admin_user = false
        @superadmin_user = false
        @member = true
      end
    #else you are not a member and do not have a role
    else
      @admin_user = false
      @superadmin_user = false
      @member = false
    end
  end

  #This checks to see if the current user is logged into a session
  def logged_in?
    #If there is a session for the current user
    if session[:user_id]
      # set current user object to @current_user object variable
      # if it fails then the user has been deleted or logged out
      # so delete the session
      begin
      @current_user = User.find session[:user_id]
      rescue ActiveRecord::RecordNotFound
        session[:user_id] = nil # or reset_session
        #Because the session is deleted the current user is no longer logged in
        return false
      end
      # The current user has a session so they are logged in
      return true
    else
      #The current user does not have a session so they are not logged in
      return false
    end
  end

  #If you need to be logged in to use a certain authorization force the user to login
  def make_user_login
    #If you aren't logged in redirect to login page
    if !logged_in?
      redirect_to(:controller => 'sessions', :action => 'login')
    end
  end

  #If you are logged in you can't go to the login page or the signup page
  def save_login_state
    if session[:user_id]

      puts "I have a session too"
      redirect_to(:controller => 'sessions', :action => 'home')

      return false
    else
      return true
    end
  end
end