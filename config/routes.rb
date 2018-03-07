Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get"/sergii_first_product" => "products#get_first_product"
  get"/sergii_all_products" => "products#get_all_products"
end
