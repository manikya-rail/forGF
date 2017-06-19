require 'test_helper'

class HolesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hole = holes(:one)
  end

  test "should get index" do
    get holes_url
    assert_response :success
  end

  test "should get new" do
    get new_hole_url
    assert_response :success
  end

  test "should create hole" do
    assert_difference('Hole.count') do
      post holes_url, params: { hole: { mhcp: @hole.mhcp, par: @hole.par, whcp: @hole.whcp, yards: @hole.yards } }
    end

    assert_redirected_to hole_url(Hole.last)
  end

  test "should show hole" do
    get hole_url(@hole)
    assert_response :success
  end

  test "should get edit" do
    get edit_hole_url(@hole)
    assert_response :success
  end

  test "should update hole" do
    patch hole_url(@hole), params: { hole: { mhcp: @hole.mhcp, par: @hole.par, whcp: @hole.whcp, yards: @hole.yards } }
    assert_redirected_to hole_url(@hole)
  end

  test "should destroy hole" do
    assert_difference('Hole.count', -1) do
      delete hole_url(@hole)
    end

    assert_redirected_to holes_url
  end
end
