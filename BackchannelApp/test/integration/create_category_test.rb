require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "creating a category" do
    u = User.create(:username => "user1", :password => "password")
    u.role = "Administrator"
    authenticate()
    visit login_url
    fill_in :username_or_email, :with => "user1"
    fill_in :login_password, :with => "password"
    click_button "Log In"

    visit new_category_url
    fill_in :category_name, :with => "Homework"
    #fill_in :title, :with => "Homework 1"
    #select "Homework"
    #fill_in :post_content, :with => "When is homework 1 due?"
    #fill_in :post_tag, :with => "HW1"
    #click_button 'Create Post'
  end
end