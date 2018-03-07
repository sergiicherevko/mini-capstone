class ProductsController < ApplicationController
  def get_first_product
    product = Product.first
    render json: {
      name: product.name,
      price: product.price,
      description: product.description
    }
  end

  def get_all_products
    products = Product.all 

    products_array = products.map do |product|
    {
      id: product.id,
      name: product.name,
      price: product.price,
      description: product.description
    }
    end
    render json: products_array.as_json
  end
end
