require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get about_me" do
    get :about_me
    assert_response :success
  end

  test "should get projects" do
    get :projects
    assert_response :success
  end

end
