require "test_helper"

class Admin::ToysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_toys_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_toys_show_url
    assert_response :success
  end
end
