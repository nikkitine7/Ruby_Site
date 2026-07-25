require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "product catalog loads" do
    product = Product.create!(name: "Test product", price: 10, description: "A test product")
    get products_path
    assert_response :success
    assert_includes response.body, product.name
  end

  test "product detail page loads" do
    product = Product.create!(name: "Test product", price: 10, description: "A test product")
    get product_path(product)
    assert_response :success
    assert_includes response.body, product.name
  end

  test "adding to cart works" do
    product = Product.create!(name: "Test product", price: 10, description: "A test product")
    post add_to_cart_product_path(product)
    assert_redirected_to products_path
    assert_equal 1, session[:cart][product.id.to_s]
  end
end
