require 'test_helper'

class Api::V1::CardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_cards_index_url
    assert_response :success
  end

end
