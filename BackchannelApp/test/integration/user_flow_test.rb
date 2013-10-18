require 'integration_test_helper'
require 'test_helper'

class UserFlowTest < ActionDispatch::IntegrationTest
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
    click_link 'Not a member?'
    assert page.has_content?("Sign Up")
    fill_in 'user_username', :with => "newTestUser"
    fill_in 'user_password', :with => "password"
    fill_in 'user_password_confirmation', :with => "password"
    click_button 'Signup'
    assert page.has_content?("Home Page")
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
    visit '/'
    fill_in 'username_or_email', :with => ""
    fill_in 'login_password', :with => ""
    click_button 'Log In'
    assert page.has_content?("Invalid")

  end

  test "viewing user profile" do
    visit '/'
    fill_in 'username_or_email', :with => "member_1"
    fill_in 'login_password', :with => "password"
    click_button 'Log In'
    click_link 'Profile'
    assert page.has_content?("Username")
    click_link 'Log out'
  end

  test "deleting user" do
    visit '/'
    fill_in 'username_or_email', :with => "member_1"
    fill_in 'login_password', :with => "password"
    click_button 'Log In'
    click_link 'Profile'
    click_link 'Delete'
    assert page.has_content?("Log in")
  end


end