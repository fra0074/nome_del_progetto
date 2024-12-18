require "test_helper"

class TransUnitsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get trans_units_index_url
    assert_response :success
  end
end
