require 'test_helper'

class SearchTest < ActionDispatch::IntegrationTest
  test "creating a post" do
    u = User.create(:username => "user1", :password => "password")
    c = Category.create(:name => "Homework")
    visit login_url
    fill_in :username_or_email, :with => "user1"
    fill_in :login_password, :with => "password"
    click_button "Log In"

    visit new_post_url

    #fill_in :title, :with => "Homework 1"
    #select "Homework"
    #fill_in :post_content, :with => "When is homework 1 due?"
    #fill_in :post_tag, :with => "HW1"
    #click_button 'Create Post'
  end
end