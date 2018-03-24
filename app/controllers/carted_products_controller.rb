class CartedProductsController < ApplicationController
  def create 
    carted_product = CartedProduct.new(
      product_id: params["product_id"],
      quantity: params["quantity"],
      user_id: current_user.id,
      status: "Carted"
      )
    if carted_product.save
      render json: {message: "Order Created"}, status: :created 
    else
      render json: {errors: carted_product.full_messages}, status: :created
    end
  end
end
