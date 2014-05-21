require 'test_helper'

class ActivitiesControllerTest < ActionController::TestCase


  test "should get index" do
    sign_in users(:roberto)
    get :index
    assert_response :success
  end


end
