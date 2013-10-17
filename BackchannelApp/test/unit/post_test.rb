require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test "should require attributes" do
    p = Post.new
    assert !p.valid?
  end

  test "should return non empty search with valid username" do
    result = Post.search( 'username',  'member_1')
    assert result.size > 0
  end
  test "should return non empty search with valid category" do
    result = Post.search( 'category',  'Category1')
    assert result.size > 0
  end
  test "should return empty search with invalid username" do
    result = Post.search( 'username',  'member_x')
    assert result.size == 0
  end
  test "should return empty search with invalid category" do
    result = Post.search( 'category',  'CategoryX')
    assert result.size == 0
  end
end
