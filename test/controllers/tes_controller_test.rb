require 'test_helper'

class TesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @te = tes(:one)
  end

  test "should get index" do
    get tes_url
    assert_response :success
  end

  test "should get new" do
    get new_te_url
    assert_response :success
  end

  test "should create te" do
    assert_difference('Te.count') do
      post tes_url, params: { te: {  } }
    end

    assert_redirected_to te_url(Te.last)
  end

  test "should show te" do
    get te_url(@te)
    assert_response :success
  end

  test "should get edit" do
    get edit_te_url(@te)
    assert_response :success
  end

  test "should update te" do
    patch te_url(@te), params: { te: {  } }
    assert_redirected_to te_url(@te)
  end

  test "should destroy te" do
    assert_difference('Te.count', -1) do
      delete te_url(@te)
    end

    assert_redirected_to tes_url
  end
end
