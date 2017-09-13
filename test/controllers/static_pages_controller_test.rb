require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get admin redirect without id" do
    get :admin
    assert_response :redirect
  end

  test "should get admin with id" do
    get :admin, { :id => 'MA==' }
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
