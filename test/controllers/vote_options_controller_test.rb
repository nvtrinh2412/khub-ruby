require "test_helper"

class VoteOptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vote_option = vote_options(:one)
  end

  test "should get index" do
    get vote_options_url, as: :json
    assert_response :success
  end

  test "should create vote_option" do
    assert_difference("VoteOption.count") do
      post vote_options_url, params: { vote_option: { count: @vote_option.count, slide_id: @vote_option.slide_id, text: @vote_option.text } }, as: :json
    end

    assert_response :created
  end

  test "should show vote_option" do
    get vote_option_url(@vote_option), as: :json
    assert_response :success
  end

  test "should update vote_option" do
    patch vote_option_url(@vote_option), params: { vote_option: { count: @vote_option.count, slide_id: @vote_option.slide_id, text: @vote_option.text } }, as: :json
    assert_response :success
  end

  test "should destroy vote_option" do
    assert_difference("VoteOption.count", -1) do
      delete vote_option_url(@vote_option), as: :json
    end

    assert_response :no_content
  end
end
