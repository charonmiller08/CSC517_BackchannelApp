class SessionsController < ApplicationController
  before_filter :save_login_state, :only => [:login, :login_attempt]
  def login
     render "login"
  end

  def login_attempt
    authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
    #puts "Hello 1"
    #puts authorized_user

    if authorized_user
      session[:user_id] = authorized_user.id
      #puts authorized_user.id
      flash[:notice] = "Wow Welcome again, you logged in as {authorized_user.username}"
      #puts "should have rendered."
      redirect_to home_url
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "login"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to home_url
  end



end
