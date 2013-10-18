require 'integration_test_helper'
require 'test_helper'

class PostTest < ActionDispatch::IntegrationTest
  test "searching for a post" do
    visit '/'
    fill_in 'search', :with => ""
    select 'category', :from => 'name'
    click_button 'Search'
    assert page.has_content?("Listing Posts")
  end

  test "viewing all posts" do
    visit '/'
    click_link 'Show All Posts'
    assert page.has_content?("Listing Posts")
  end

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
    click_link 'Log out'
  end

  test "viewing a post" do
    visit '/'
    click_link 'Show All Posts'
    click_link 'Show', :match => :first
    assert page.has_content?("Post")
  end

  test "editing a post as a valid user" do
    visit '/'
    fill_in 'username_or_email', :with => "member_1"
    fill_in 'login_password', :with => "password"
    click_button 'Log In'
    click_link 'Make a new Post'
    fill_in 'post_title', :with => "My Next Post"
    select 'Category1', :from => 'post_category_id'
    fill_in 'post_content', :with => "This is another test post."
    click_button 'Create Post'
    click_link 'Edit'
    assert page.has_content?("Editing post")
    fill_in 'post_content', :with => "I have rewritten this post."
    click_button 'Update Post'
    assert page.has_content?("Post was successfully updated.")
    click_link 'Log out'
  end


  test "destroying a post as a valid user" do
    visit '/'
    fill_in 'username_or_email', :with => "member_1"
    fill_in 'login_password', :with => "password"
    click_button 'Log In'
    click_link 'Make a new Post'
    fill_in 'post_title', :with => "My Next Post"
    select 'Category1', :from => 'post_category_id'
    fill_in 'post_content', :with => "This is another test post."
    click_button 'Create Post'
    click_link 'Destroy'
    assert page.has_content?('Listing Posts')
    click_link 'Log out'
  end


  test "up voting post as a valid user" do
    visit '/'
    fill_in 'username_or_email', :with => "member_1"
    fill_in 'login_password', :with => "password"
    click_button 'Log In'
    fill_in 'search', :with => "Post_3"
    select 'title', :from => 'name'
    click_button 'Search'
    click_link 'Vote'
    click_link 'Log out'
  end

end