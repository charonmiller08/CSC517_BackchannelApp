require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  test "logging in with valid username and password" do
    User.create(:username => "user1", :password => "password")
    visit login_url
    #save_and_open_page
    fill_in :username_or_email, :with => "user1"
    fill_in :login_password, :with => "password"
    click_button "Log In"
    #puts session[:user_id]
    #TODO: assert logged_in? == true
    automate do
      selenium.wait_for_page_to_load(5)
    end
    #assert @current_user == nil
    #assert_contain "Welcome."

  end
  test "unable to login without valid username or password"  do
    User.create(:username => "user1", :password => "password")
    visit login_url
    #save_and_open_page
    fill_in :username_or_email, :with => "user1"
    fill_in :login_password, :with => "wrong_password"
    #TODO: assert logged_in? == false
  end
end
