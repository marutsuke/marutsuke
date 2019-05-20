require 'test_helper'

class BuyControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get buy_new_url
    assert_response :success
  end

  test "should get create" do
    get buy_create_url
    assert_response :success
  end

  test "should get index" do
    get buy_index_url
    assert_response :success
  end

  test "should get destroy" do
    get buy_destroy_url
    assert_response :success
  end

end
