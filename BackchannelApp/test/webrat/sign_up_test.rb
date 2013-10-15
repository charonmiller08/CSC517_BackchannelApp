require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest
  test "sign up with valid username and password" do
    visit login_url
    visit signup_url
    fill_in :user_username, :with => "user1"
    fill_in :user_password, :with => "password"
    fill_in :user_password_confirmation, :with => "password"
    click_button "Signup"

  end
  test "unable to sign up if username exists"  do
    User.create(:username => "user1", :password => "password")
    visit signup_url

  end
end
