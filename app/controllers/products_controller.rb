class ProductsController < ApplicationController
  before_action :authenticate_admin, except: [:index, :show]

  def index
    if true #current_user
      products = Product.all
      search_criteria = params["search_criteria"]
      if search_criteria
        products = products.where("name LIKE ?", "%#{search_criteria}%")
      end
      if params["order_by_name"]
        products = Product.all.order(name: :asc)
      else
        products = Product.all.order(id: :asc)
      end
      render json: products.as_json
    else
      render json: []
    end
  end
  
  def show
    product_id = params["id"]
    product = Product.find_by(id: product_id)
    render json: product.as_json
  end

  def create
    product = Product.new(
      name: params["input_name"],
      price: params["input_price"],
      # image_url: params["input_image_url"],
      description: params["input_description"],
      supplier_id: params["supplier_id"]
      )
    if product.save
      image = Image.new(
        url: params["input_image_url"],
        product_id: product.id
      )
      image.save
      render json: product.as_json
    else
      render json: {errors: product.errors.full_messages}, status: :unprocessable_entity
    end
  end
  
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

  def destroy
    product_id = params["id"]
    product = Product.find_by(id: product_id)
    product.destroy
    render json: {message: "The product was destroyed."}
  end
end

