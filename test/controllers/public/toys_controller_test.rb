require "test_helper"

class Public::ToysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_toys_index_url
    assert_response :success
  end

  test "should get show" do
    get public_toys_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_toys_edit_url
    assert_response :success
  end
end
