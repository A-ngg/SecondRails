require "test_helper"

class RatingsControllerTest < ActionDispatch::IntegrationTest
  test "should get rate" do
    get ratings_rate_url
    assert_response :success
  end
end
