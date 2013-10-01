require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest
  test "sign up with valid username and password" do
    visit login_url
    visit signup_url
    puts "******"
    puts signup_url
    puts "******"
    fill_in 'username', :with => "user1"
    fill_in :password, :with => "password"
    fill_in :password_confirmation, :with => "password"

  end
  test "unable to sign up if username exists"  do
    User.create(:username => "user1", :password => "password")
    visit signup_url

  end
end
