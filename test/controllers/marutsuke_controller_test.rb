require 'test_helper'

class MarutsukeControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get marutsuke_create_url
    assert_response :success
  end

end
