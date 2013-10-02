class SessionsController < ApplicationController
  #If you are already logged in you can't login twice
  before_filter :save_login_state, :only => [:login, :login_attempt]
  #Store the location of the last url before this call so that you can return
  after_filter :store_location
  #this is used for authentication of the user
  before_filter :logged_in?

  #Login page is on the home page when you are not logged in so redirect to home
  def login
    redirect_to home_url  and return
    render :nothing => true
  end

  #This is the form for the login, if the current user is a member then you may be logged in
  def login_attempt
    #This calls a method in the User class which validates that the username and password math
    #the database
    authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
    #If the current user is in the database then they are assigned to a session to keep track
    # of the user throughout navigation of the web app until they are logged out
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "Welcome! You are logged in as #{authorized_user.username}."
      flash[:color] = "valid"
      redirect_to home_url
    #If the user does not exist in the database they are not allowed to login and are redirected
    #to the login page
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      redirect_to home_url
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "You have been successfully logged out"
    flash[:color] = "valid"
    redirect_to home_url
  end
  def home
     render "home"
  end
end
