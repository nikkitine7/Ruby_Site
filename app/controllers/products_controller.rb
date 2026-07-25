class ProductsController < ApplicationController
  def index
    @products = Product.order(created_at: :desc)
    @cart_count = cart.values.sum
  end

  def show
    @product = Product.find(params[:id])
    @cart_count = cart.values.sum
  end

  def add_to_cart
    product = Product.find(params[:id])
    cart[product.id.to_s] = cart.fetch(product.id.to_s, 0) + 1
    redirect_to products_path, notice: "Added #{product.name} to your cart."
  end
end
