class OrdersController < ApplicationController
  def new
    @items = []
    cart.each do |product_id, quantity|
      product = Product.find_by(id: product_id)
      @items << { product: product, quantity: quantity } if product
    end
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.status = "placed"
    @order.user = current_user
    @order.total = 0
    @order.user_id = nil if @order.user.nil?
    if @order.save
      cart.each do |product_id, quantity|
        product = Product.find_by(id: product_id)
        next unless product
        @order.order_items.create(product: product, quantity: quantity, price: product.price)
        @order.total += product.price * quantity
      end
      @order.save
      session[:cart] = {}
      redirect_to success_order_path(@order), notice: "Order placed successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def success
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:email, :shipping_name, :shipping_address, :shipping_city, :shipping_state, :shipping_zip)
  end
end
