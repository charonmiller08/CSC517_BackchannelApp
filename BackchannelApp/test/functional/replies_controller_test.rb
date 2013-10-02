require 'test_helper'

class RepliesControllerTest < ActionController::TestCase
  setup do
    @reply = replies(:one)
    user = User.create(:username => "testUser", :password => "password", :role => "Administrator")
    authorized_user = User.authenticate(user.username,user.password)
    if authorized_user
      session[:user_id] = authorized_user.id
    end
  end

  #test "should get index" do
  # get :index
  # assert_response :success
  #  assert_not_nil assigns(:replies)
  #end

  #test "should get new_" do
  #  get :new
  #  assert_response :success
  #end

  #test "should create reply" do
  #  assert_difference('Reply.count') do
  #    post :create, reply: {  }
  #  end

    #assert_redirected_to post_path(assigns(:reply))
  #end



  #test "should get edit" do
  #  get :edit, id: @reply
  #  assert_response :success
  #end

  test "should update reply" do
    put :update, id: @reply, reply: {  }
    assert_redirected_to reply_path(assigns(:reply))
  end

  test "should destroy reply" do
    assert_difference('Reply.count', -1) do
      delete :destroy, id: @reply
    end

    assert_redirected_to posts_path
  end
end
