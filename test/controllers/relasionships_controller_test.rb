require "test_helper"

class RelasionshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get relasionships_create_url
    assert_response :success
  end

  test "should get destroy" do
    get relasionships_destroy_url
    assert_response :success
  end
end
