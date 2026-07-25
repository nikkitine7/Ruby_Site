class CartsController < ApplicationController
  def show
    @items = []
    cart.each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      @items << { product: product, quantity: quantity } if product
    end
    @cart_count = cart.values.sum
  end

  def remove
    product_id = params[:product_id] || params[:id]
    cart.delete(product_id.to_s)
    redirect_to cart_path, notice: "Item removed from cart."
  end
end
