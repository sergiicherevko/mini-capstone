class CartedProductsController < ApplicationController
  def index
    carted_products = CartedProduct.all
    if current_user
      carted_products = carted_products.where(user_id: current_user.id, status: "carted")
    end

    render json: carted_products.as_json
  end

  def create 
    carted_product = CartedProduct.new(
      product_id: params["product_id"],
      quantity: params["quantity"],
      user_id: current_user.id,
      status: "carted"
      )
    if carted_product.save
      render json: {message: "Order Created"}, status: :created 
    else
      render json: {errors: carted_product.full_messages}, status: :created
    end
  end
end
