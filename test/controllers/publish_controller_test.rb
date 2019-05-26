require 'test_helper'

class PublishControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get publish_update_url
    assert_response :success
  end

end
