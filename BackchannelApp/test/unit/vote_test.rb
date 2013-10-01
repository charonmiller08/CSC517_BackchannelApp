require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test "should require attributes" do
    v = Vote.new
    #assert !v.valid?
  end
end
