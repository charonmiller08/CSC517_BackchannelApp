require 'integration_test_helper'
require 'test_helper'

class PostTest < ActionDispatch::IntegrationTest
  test "making a new post as a valid user" do
    visit '/'
    fill_in 'username_or_email', :with => "member_1"
    fill_in 'login_password', :with => "password"
    click_button 'Log In'
    click_link 'Make a new Post'
    assert page.has_content?("New Post")
    fill_in 'post_title', :with => "My Post"
    select 'Category1', :from => 'post_category_id'
    fill_in 'post_content', :with => "This is a test post."
    fill_in 'post_tag', :with => "test, category 1"
    click_button 'Create Post'
    assert page.has_content?("Thank you for posting!")
  end
end