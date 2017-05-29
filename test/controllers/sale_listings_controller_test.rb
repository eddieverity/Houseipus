require 'test_helper'

class SaleListingsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get sale_listings_new_url
    assert_response :success
  end

  test "should get create" do
    get sale_listings_create_url
    assert_response :success
  end

  test "should get show" do
    get sale_listings_show_url
    assert_response :success
  end

end
