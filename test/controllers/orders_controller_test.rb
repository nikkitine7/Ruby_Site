require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "checkout page loads" do
    get new_order_path
    assert_response :success
  end

  test "placing an order works" do
    assert_difference("Order.count", 1) do
      post orders_path, params: { order: { email: "buyer@example.com", shipping_name: "Buyer", shipping_address: "1 Main St", shipping_city: "City", shipping_state: "ST", shipping_zip: "12345" } }
    end
    assert_redirected_to success_order_path(Order.last)
  end
end
