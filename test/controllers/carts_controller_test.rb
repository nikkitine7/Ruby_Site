require "test_helper"

class CartsControllerTest < ActionDispatch::IntegrationTest
  test "cart page loads" do
    get cart_path
    assert_response :success
  end

  test "removing an item works" do
    delete remove_cart_path(product_id: 1)
    assert_redirected_to cart_path
  end
end
