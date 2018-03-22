class OrdersController < ApplicationController
  before_action :authenticate_user

  def create
    product_id = params["product_id"].to_i
    quantity = params["quantity"].to_i
    product = Product.find_by(id: product_id)


    subtotal = quantity * product.price
    tax = subtotal * 0.09
    total = tax + subtotal

    order  = Order.new(
      user_id: current_user.id,
      product_id: product_id,
      quantity: quantity,
      subtotal: subtotal,
      tax: tax,
      total: total
      )
    order.save
    render json: order.as_json
  end
end



    # product = Product.new(
    #   name: params["input_name"],
    #   price: params["input_price"],
    #   image_url: params["input_image_url"],
    #   description: params["input_description"]
    #   )
    # if product.save
    #   render json: product.as_json
    # else
    #   render json: {errors: product.errors.full_messages}, status: :unprocessable_entity
    # end

