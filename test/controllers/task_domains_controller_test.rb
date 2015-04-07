require 'test_helper'

class TaskDomainsControllerTest < ActionController::TestCase
  setup do
    @task_domain = task_domains(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:task_domains)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create task_domain" do
    assert_difference('TaskDomain.count') do
      post :create, task_domain: { description: @task_domain.description, title: @task_domain.title }
    end

    assert_redirected_to task_domain_path(assigns(:task_domain))
  end

  test "should show task_domain" do
    get :show, id: @task_domain
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @task_domain
    assert_response :success
  end

  test "should update task_domain" do
    patch :update, id: @task_domain, task_domain: { description: @task_domain.description, title: @task_domain.title }
    assert_redirected_to task_domain_path(assigns(:task_domain))
  end

  test "should destroy task_domain" do
    assert_difference('TaskDomain.count', -1) do
      delete :destroy, id: @task_domain
    end

    assert_redirected_to task_domains_path
  end
end
