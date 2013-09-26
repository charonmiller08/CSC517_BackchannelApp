class SessionsController < ApplicationController
  before_filter :authenticate_user, :only => [:home, :profile, :setting]
  before_filter :save_login_state, :only => [:login, :login_attempt]
  def login
    authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
    puts "Hello"
    puts authorized_user

    if authorized_user
      session[:user_id] = authorized_user.id
      puts authorized_user.id
      flash[:notice] = "Wow Welcome again, you logged in as {authorized_user.username}"
      redirect_to home_url
    else
      flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
      render "login"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :action => 'login'
  end


  %%
  def create
   user = User.find_by_username(params[:session][:username]);
   if user && User.authenticate(params[:session][:username].downcase, params[:session][:password])
      # Sign the user in and redirect to the user's show page.
     #puts user.username
     flash[:notice] = 'Welcome to Backchannel App!'
     redirect_to root_url
   else
      # Create an error message and re-render the signin form.
      flash[:error] = 'Invalid email/password combination' # Not quite right!
      flash[:color] = "invalid"
      render 'new'
    end
  end

  def destroy
      self.current_user.forget_me
      reset_session
      flash[:notice] = "You have been logged out."
      redirect_back_or_default('/');
  end
%
end
