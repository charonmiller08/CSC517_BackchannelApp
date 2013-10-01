require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = categories(:one)
    user = User.create(:username => "testUser", :password => "password", :role => "Administrator")
    authorized_user = User.authenticate(user.username,user.password)
    if authorized_user
      session[:user_id] = authorized_user.id
    end
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should get new_as" do
    get :new_as
    assert_response :success
  end

  test "should create category" do
    @current_user = User.new
    @current_user.role = "Administrator"
    assert_difference('Category.count') do
      post :create, category: { name: @category.name }
    end

    assert_redirected_to category_path(assigns(:category))
  end

  test "should show category" do
    get :show, id: @category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @category
    assert_response :success
  end

  test "should update category" do
    put :update, id: @category, category: { name: @category.name }
    assert_redirected_to category_path(assigns(:category))
  end

  test "should destroy category" do
    assert_difference('Category.count', -1) do
      delete :destroy, id: @category
    end

    assert_redirected_to categories_path
  end
end
