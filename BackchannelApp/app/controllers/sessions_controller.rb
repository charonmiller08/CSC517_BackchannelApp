class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find(params[:session][:username].downcase)

    if user = User.authenticate(username: params[:session][:username].downcase, params[:session][:password])
      # Sign the user in and redirect to the user's show page.

    else
      # Create an error message and re-render the signin form.
      flash[:error] = 'Invalid email/password combination' # Not quite right!
      render 'new'
    end
  end

  def destroy

  end
end
