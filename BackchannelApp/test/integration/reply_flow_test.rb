require 'integration_test_helper'
require 'test_helper'

class ReplyFlowTest < ActionDispatch::IntegrationTest
  test "making a reply as valid user" do
    visit '/'
    fill_in 'username_or_email', :with => "member_1"
    fill_in 'login_password', :with => "password"
    click_button 'Log In'
    fill_in 'search', :with => "Post_1"
    select 'title', :from => 'name'
    click_button 'Search'
    click_link 'Show'
    click_link 'New Reply'
    fill_in 'post_content', :with => "My new reply."
    click_button 'Create Reply'
    assert page.has_content?("Reply was successfully created.")
    click_link 'Log out'
  end

  test "editing a reply as a valid user" do
    visit '/'
    fill_in 'username_or_email', :with => "member_1"
    fill_in 'login_password', :with => "password"
    click_button 'Log In'
    fill_in 'search', :with => "Post_1"
    select 'title', :from => 'name'
    click_button 'Search'
    click_link 'Show'
    click_link 'Edit'
    fill_in 'post_content', :with => "An edited reply"
    click_button 'Create Reply'
    assert page.has_content?("Reply was successfully updated")
    click_link 'Log out'
  end

  test "deleting a reply as a valid user" do
    visit '/'
    fill_in 'username_or_email', :with => "member_1"
    fill_in 'login_password', :with => "password"
    click_button 'Log In'
    fill_in 'search', :with => "Post_1"
    select 'title', :from => 'name'
    click_button 'Search'
    click_link 'Show'
    click_link 'Destroy'
    click_link 'Log out'
  end

  test "voting for reply as a valid user" do
    visit '/'
    fill_in 'username_or_email', :with => "member_1"
    fill_in 'login_password', :with => "password"
    click_button 'Log In'
    fill_in 'search', :with => "Post_3"
    select 'title', :from => 'name'
    click_button 'Search'
    click_link 'Show'
    click_link 'Vote', :match => :first
    assert page.has_content?("Thank you")
    click_link 'Log out'
  end

end