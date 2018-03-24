Rails.application.routes.draw do
  #User_toker
  # post 'user_token' => 'user_token#create' ???
  post "/user_token" => "user_token#create"

  #Products
  get"/products" => "products#index"
  get"/products/:id" => "products#show"
  post "/products" => "products#create"
  patch "/products/:id" => "products#update"
  delete "/products/:id" => "products#destroy"

  #User
  post"/users" => "users#create"

  #Orders
  post "/orders" => "orders#create"

  #CartedProducts
  post "/carted_products" => "carted_products#create"
end


