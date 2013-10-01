require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "should require attributes" do
    p = Post.new
    assert !p.valid?
  end
end
