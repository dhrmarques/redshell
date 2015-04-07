require 'test_helper'

class ResponsibilitiesControllerTest < ActionController::TestCase
  setup do
    @responsibility = responsibilities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:responsibilities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create responsibility" do
    assert_difference('Responsibility.count') do
      post :create, responsibility: {  }
    end

    assert_redirected_to responsibility_path(assigns(:responsibility))
  end

  test "should show responsibility" do
    get :show, id: @responsibility
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @responsibility
    assert_response :success
  end

  test "should update responsibility" do
    patch :update, id: @responsibility, responsibility: {  }
    assert_redirected_to responsibility_path(assigns(:responsibility))
  end

  test "should destroy responsibility" do
    assert_difference('Responsibility.count', -1) do
      delete :destroy, id: @responsibility
    end

    assert_redirected_to responsibilities_path
  end
end
