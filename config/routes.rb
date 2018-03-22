Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  get"/products" => "products#index"
  get"/products/:id" => "products#show"
  post "/products" => "products#create"
  patch "/products/:id" => "products#update"
  delete "/products/:id" => "products#destroy"

  #User
  post"/users" => "users#create"
  post "/user_token" => "user_token#create"

  #Orders
  post "/orders" => "orders#create"
end


