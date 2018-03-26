class OrdersController < ApplicationController
  before_action :authenticate_user

  def create
    carted_products = current_user.carted_products.where(status: "carted")

    calculated_subtotal = 0 

    carted_products.each do |carted_product|
      calculated_subtotal += carted_product.quantity * carted_product.product.price
    end

    calculated_tax = calculated_subtotal * 0.09
    calculated_total = calculated_tax + calculated_subtotal

    order = Order.new(
      user_id: current_user.id,
      subtotal: calculated_subtotal,
      tax: calculated_tax,
      total: calculated_total
      )
    order.save
    render json: order.as_json

    carted_products.each do |carted_product|
      carted_product.status = "purchased"
      carted_product.order_id = order.id
      carted_product.save
    end
  end
end

