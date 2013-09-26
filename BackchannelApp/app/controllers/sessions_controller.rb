class SessionsController < ApplicationController
  def new
  end

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
      render 'new'
    end
  end

  def destroy

  end
end
