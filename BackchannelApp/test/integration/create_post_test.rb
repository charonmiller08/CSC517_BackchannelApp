require 'test_helper'

class SearchTest < ActionDispatch::IntegrationTest
  test "creating a post" do
    User.create(:username => "user1", :password => "password")
    visit login_url
    fill_in :username_or_email, :with => "user1"
    fill_in :login_password, :with => "password"
    click_button "Log In"
    puts "***"
    puts new_post_url
    puts "***"
    visit new_post_url

    #fill_in :post_title, :with => "Homework 1"
    #select 'Homework'
    #fill_in :post_content, :with => "When is homework 1 due?"
    #fill_in :post_tag, :with => "HW1"
    #click_button 'Create Post'
  end
end