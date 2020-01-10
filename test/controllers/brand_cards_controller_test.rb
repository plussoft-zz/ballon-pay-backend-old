require 'test_helper'

class BrandCardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @brand_card = brand_cards(:one)
  end

  test "should get index" do
    get brand_cards_url, as: :json
    assert_response :success
  end

  test "should create brand_card" do
    assert_difference('BrandCard.count') do
      post brand_cards_url, params: { brand_card: { name: @brand_card.name, number: @brand_card.number, status: @brand_card.status, user_id: @brand_card.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show brand_card" do
    get brand_card_url(@brand_card), as: :json
    assert_response :success
  end

  test "should update brand_card" do
    patch brand_card_url(@brand_card), params: { brand_card: { name: @brand_card.name, number: @brand_card.number, status: @brand_card.status, user_id: @brand_card.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy brand_card" do
    assert_difference('BrandCard.count', -1) do
      delete brand_card_url(@brand_card), as: :json
    end

    assert_response 204
  end
end
