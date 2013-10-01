require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
    user = User.create(:username => "testUser", :password => "password", :role => "Administrator")
    authorized_user = User.authenticate(user.username,user.password)
    if authorized_user
      session[:user_id] = authorized_user.id
    end
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new_as" do
    get :new_as
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, post: { content: @post.content }
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    get :show, id: @post
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post
    assert_response :success
  end

  test "should update post" do
    put :update, id: @post, post: { content: @post.content }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
  end
end
