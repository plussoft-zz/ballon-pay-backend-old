require 'test_helper'

class CreditProposalControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get credit_proposal_index_url
    assert_response :success
  end

end
