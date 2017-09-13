require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get admin" do
    get :admin
    assert_response :success
  end

  test "should get console" do
    get :console
    assert_response :success
  end

  test "should get config" do
    get :configure
    assert_response :success
  end

  test "should get maint" do
    get :maint
    assert_response :success
  end

end
