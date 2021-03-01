require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest

  test "should get root" do
    get root_path
    assert_response :success
    assert_select "title", "DiaryApp top"
  end
end
