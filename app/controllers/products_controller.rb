class ProductsController < ApplicationController
  def update
    product_id = params["id"]
    product = Product.find_by(id: product_id)
    product.name = params["input_name"]
    product.price = params["input_price"]
    product.image_url = params["input_image_url"]
    product.description = params["input_description"]
    if product.save
      render json: product.as_json
    else
      render json: {errors: product.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def create
    product = Product.new(
      name: params["input_name"],
      price: params["input_price"],
      image_url: params["input_image_url"],
      description: params["input_description"]
      )
    if product.save
      render json: product.as_json
    else
      render json: {errors: product.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def index
    products = Product.all 
    render json: products.as_json
  end

  def show
    product_id = params["id"]
    product = Product.find_by(id: product_id)
    render json: product.as_json
  end

  def destroy
    product_id = params["id"]
    product = Product.find_by(id: product_id)
    product.destroy
    render json: {message: "The product was destroyed."}
  end
end
