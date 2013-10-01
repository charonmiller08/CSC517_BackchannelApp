require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "should require attributes" do
    c = Category.new
    assert !c.valid?
  end
end
