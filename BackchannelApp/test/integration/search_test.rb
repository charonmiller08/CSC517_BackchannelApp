require 'test_helper'

class SearchTest < ActionDispatch::IntegrationTest
  test "searching categories" do
    visit home_url

    fill_in :search, :with => "Homework"
    select 'category'
    click_button 'Search'
  end
end