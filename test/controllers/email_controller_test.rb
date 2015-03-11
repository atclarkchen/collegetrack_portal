require 'test_helper'

class EmailControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get send" do
    get :send
    assert_response :success
  end

end
