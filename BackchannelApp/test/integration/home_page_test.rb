require 'integration_test_helper'
require 'test_helper'

class HomePageTest < ActionDispatch::IntegrationTest
  test "viewing home page" do
    visit '/'
    assert page.has_content?("Home Page")
  end

  test "clicking home link" do
    visit '/'
    click_link 'Home'
    assert page.has_content?("Home Page")
  end

  test "signing up as a valid user" do
    visit '/'
    #save_and_open_page
    click_link 'Not a member?'
    assert page.has_content?("Sign Up")
    fill_in 'user_username', :with => "newTestUser"
    fill_in 'user_password', :with => "password"
    fill_in 'user_password_confirmation', :with => "password"
    #save_and_open_page
    click_button 'Signup'
    assert page.has_content?("Home Page")
  end

  test "attempting sign up with invalid parameters" do
    #TODO invalid sign up (user exists, incorrect password confirmation, etc)
  end


  test "logging in and out as a valid user" do
    # using fixture user name
    visit '/'
    fill_in 'username_or_email', :with => "member_1"
    fill_in 'login_password', :with => "password"
    click_button 'Log In'
    assert page.has_content?("Welcome member_1")
    click_link 'Log out'
    assert page.has_content?("You have been successfully logged out")

  end

  test "attempting log in with invalid parameters" do
    #TODO make test for invalid login (incorrect username, password)
  end


end