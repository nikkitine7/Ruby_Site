require "test_helper"

class Admin::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = User.create!(email: "admin_test@example.com", password: "password123", password_confirmation: "password123", role: "admin")
    post session_path, params: { email: @admin.email, password: "password123" }
  end

  test "admin dashboard loads" do
    get admin_dashboard_path
    assert_response :success
  end

  test "admin can create a product" do
    assert_difference("Product.count", 1) do
      post admin_products_path, params: { product: { name: "New product", price: 15, description: "A new product" } }
    end
    assert_redirected_to admin_products_path
  end

  test "admin can edit a product" do
    product = Product.create!(name: "Old", price: 5, description: "Old description")
    patch admin_product_path(product), params: { product: { name: "Updated", price: 6, description: "Updated description" } }
    assert_redirected_to admin_products_path
    assert_equal "Updated", product.reload.name
  end

  test "admin can delete a product" do
    product = Product.create!(name: "Delete me", price: 5, description: "Delete me")
    assert_difference("Product.count", -1) do
      delete admin_product_path(product)
    end
    assert_redirected_to admin_products_path
  end
end
