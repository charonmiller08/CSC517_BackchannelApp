class StaticPagesController < ApplicationController
  #before_filter :authenticate_user, :only => [:home, :search]
  before_filter :save_login_state, :only => [:search]
  def search
       render "search"
  end
  def home
      render "home"
  end

  def login
     render "sessions#login"
  end
end
