require 'test_helper'

class ChambermaidsControllerTest < ActionController::TestCase
  setup do
    @chambermaid = chambermaids(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chambermaids)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chambermaid" do
    assert_difference('Chambermaid.count') do
      post :create, chambermaid: { login: @chambermaid.login, name: @chambermaid.name, passcode: @chambermaid.passcode, surname: @chambermaid.surname }
    end

    assert_redirected_to chambermaid_path(assigns(:chambermaid))
  end

  test "should show chambermaid" do
    get :show, id: @chambermaid
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @chambermaid
    assert_response :success
  end

  test "should update chambermaid" do
    patch :update, id: @chambermaid, chambermaid: { login: @chambermaid.login, name: @chambermaid.name, passcode: @chambermaid.passcode, surname: @chambermaid.surname }
    assert_redirected_to chambermaid_path(assigns(:chambermaid))
  end

  test "should destroy chambermaid" do
    assert_difference('Chambermaid.count', -1) do
      delete :destroy, id: @chambermaid
    end

    assert_redirected_to chambermaids_path
  end
end
