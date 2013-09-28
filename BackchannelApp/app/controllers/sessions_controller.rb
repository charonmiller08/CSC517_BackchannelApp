class SessionsController < ApplicationController
  before_filter :save_login_state, :only => [:login, :login_attempt]
  def login
    render "login"
  end

  def login_attempt
    authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "Welcome! You are logged in as #{authorized_user.username}."
      flash[:color] = "valid"
      redirect_to home_url
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "login"
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "You have been successfully logged out"
    flash[:color] = "valid"
    redirect_to home_url
  end
end
