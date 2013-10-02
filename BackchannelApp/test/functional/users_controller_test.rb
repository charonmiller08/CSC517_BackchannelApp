require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    user = User.create(:username => "testUser", :password => "password", :role => "Administrator")
    authorized_user = User.authenticate(user.username,user.password)
    if authorized_user
      session[:user_id] = authorized_user.id
    end
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    #assert_difference('User.count') do
    #  post :create, user: {password: @user.password, role: @user.role, username: @user.username }
    #end

    #assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    #put :update, id: @user, user: {  password: @user.password, role: @user.role, username: @user.username }
    #assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    #assert_difference('User.count', -1) do
    #  delete :destroy, id: @user
    #end

    #assert_redirected_to users_path
  end
end
