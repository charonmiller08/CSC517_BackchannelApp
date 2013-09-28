class StaticPagesController < ApplicationController
  #before_filter :authenticate_user, :only => [:home, :search]
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
