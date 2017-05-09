require 'test_helper'

class ScoreCardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @score_card = score_cards(:one)
  end

  test "should get index" do
    get score_cards_url
    assert_response :success
  end

  test "should get new" do
    get new_score_card_url
    assert_response :success
  end

  test "should create score_card" do
    assert_difference('ScoreCard.count') do
      post score_cards_url, params: { score_card: { color: @score_card.color, tee_name: @score_card.tee_name } }
    end

    assert_redirected_to score_card_url(ScoreCard.last)
  end

  test "should show score_card" do
    get score_card_url(@score_card)
    assert_response :success
  end

  test "should get edit" do
    get edit_score_card_url(@score_card)
    assert_response :success
  end

  test "should update score_card" do
    patch score_card_url(@score_card), params: { score_card: { color: @score_card.color, tee_name: @score_card.tee_name } }
    assert_redirected_to score_card_url(@score_card)
  end

  test "should destroy score_card" do
    assert_difference('ScoreCard.count', -1) do
      delete score_card_url(@score_card)
    end

    assert_redirected_to score_cards_url
  end
end
