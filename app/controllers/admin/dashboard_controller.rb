class Admin::DashboardController < ApplicationController
  before_action :require_admin

  def index
    @products = Product.order(created_at: :desc)
  end
end
