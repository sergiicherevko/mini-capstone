class ProductsController < ApplicationController

# • Change the index action to allow for searching by name.
# • Add an option to the frontend to search by a product’s name.
# • Bonus: Change the index action to allow for sorting by price. Add a frontend option to see the results.

  def index
    products = Product.all.order(id: :asc)
    search_criteria = params["search_criteria"]

    if search_criteria
      products = products.where("name LIKE ?", "%#{search_criteria}%") #SQL in ()
    end

    render json: products.as_json
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
      image_url: params["input_image_url"],
      description: params["input_description"]
      )
    if product.save
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
