require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should require attributes" do
    u = User.new
    assert !u.valid?
  end
end
