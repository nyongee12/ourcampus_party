require 'test_helper'

class VisitorControllerTest < ActionController::TestCase
  test "should get intro" do
    get :intro
    assert_response :success
  end

end
