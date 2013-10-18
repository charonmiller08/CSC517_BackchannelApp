require 'integration_test_helper'
require 'test_helper'

class AdminReportsFlowTest < ActionDispatch::IntegrationTest
  test "viewing reports page" do
    visit '/'
    fill_in 'username_or_email', :with => "Admin_1"
    fill_in 'login_password', :with => "password"
    click_button 'Log In'
    click_link 'Run Report'
    assert page.has_content?("What type of report")
    click_link 'Log out'
  end
  test "viewing posts per user" do
    visit '/'
    fill_in 'username_or_email', :with => "Admin_1"
    fill_in 'login_password', :with => "password"
    click_button 'Log In'
    click_link 'Run Report'
    choose 'report_type_1'
    click_button 'Submit'
    assert page.has_content?("Reporting Posts per User")
    click_link 'Log out'
  end
  test "view votes per post" do
    visit '/'
    fill_in 'username_or_email', :with => "Admin_1"
    fill_in 'login_password', :with => "password"
    click_button 'Log In'
    click_link 'Run Report'
    choose 'report_type_2'
    click_button 'Submit'
    assert page.has_content?("Reporting Posts by Votes")
    click_link 'Log out'
  end
  test "view votes per timeframe" do
    visit '/'
    fill_in 'username_or_email', :with => "Admin_1"
    fill_in 'login_password', :with => "password"
    click_button 'Log In'
    click_link 'Run Report'
    choose 'report_type_3'
    click_button 'Submit'
    assert page.has_content?("Reporting Posts by Between")
    click_link 'Log out'
  end
end