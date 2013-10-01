class StaticPagesController < ApplicationController
  #include ApplicationHelper
  before_filter :logged_in?, :except => [:login]

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
