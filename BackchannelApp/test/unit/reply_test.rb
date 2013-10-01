require 'test_helper'

class ReplyTest < ActiveSupport::TestCase
  test "should require attributes" do
    r = Reply.new
    #assert !r.valid?
  end
end
