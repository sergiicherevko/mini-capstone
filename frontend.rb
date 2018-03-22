require "unirest"

# Login and set jwt as part of Unirest requests

# Exercise:
# Use a `before_action :authenticate_admin` to prohibit non-admin users from creating, updating, and deleting products. (You’ll need to create the `authenticate_admin` method in the application_controller).

# Use a `before_action :authenticate_user` to prohibit guests (non-logged in users) to view or create orders. (You *don’t* need to create the the `authenticate_user` method, the knock gem already created it for you!)

response = Unirest.post(
  "http://localhost:3000/user_token",
  parameters: {
    auth: {
      email: "sergii@email.com",
      password: "123"
    }
  }
)
jwt = response.body["jwt"]
Unirest.default_header("Authorization", "Bearer #{jwt}")


system "clear"
puts "Your jwt is #{jwt}"

puts "Welcome to Product app! Choose an option:"
puts "[1] See all products"
puts "  [1.1] Search for product"
puts "  [1.2] Sort by price"
puts "[2] See one product"
puts "[3] Create a product"
puts "[4] Update a product"
puts "[5] Delete a product"
puts "[6] Add Order"
puts "[signup] Signup (create new user)"

user_input = gets.chomp

if 
  user_input == "1"
  respose = Unirest.get("http://localhost:3000/products")
  products = respose.body
  puts JSON.pretty_generate(products)
elsif 
  user_input == "1.1"
  print "Eneter product name: "
  input_search_criteria = gets.chomp

  respose = Unirest.get("http://localhost:3000/products?search_criteria=#{input_search_criteria}")
  product = respose.body
  puts JSON.pretty_generate(product)
elsif 
  user_input == "1.2"
  respose = Unirest.get("http://localhost:3000/products?order_by_name=true")
  products = respose.body
  puts JSON.pretty_generate(products)
elsif 
  user_input == "2"  
  print "Print products id:"
  user_input_id = gets.chomp.to_i
  response = Unirest.get("http://localhost:3000/products/#{user_input_id}")
  product = response.body
  puts JSON.pretty_generate(product)
elsif
  user_input == "3"
  print "Enter product name: "
  input_name = gets.chomp
  print "Enter product price: "
  input_price = gets.chomp
  print "Enter product image url: "
  input_image_url = gets.chomp
  print "Enter product description: "
  input_description = gets.chomp
  params = {
    "input_name" => input_name,
    "input_price" => input_price,
    "input_image_url" => input_image_url,
    "input_description" => input_description,
    "supplier_id" => "1"
  }
  respose = Unirest.post("http://localhost:3000/products", parameters: params)
  product = respose.body

  if product["errors"]
    puts "Uh oh! Something went wrong..."
    p product["errors"]
  else
    puts "Here is your product info:"
    puts JSON.pretty_generate(product)
  end
elsif 
  user_input == "4"
  print "Print a product id: "
  input_id = gets.chomp.to_i
  params = {}
  print "Name: "
  params["input_name"] = gets.chomp
  print "Price: "
  params["input_price"] = gets.chomp
  print "Description: "
  params["input_description"] = gets.chomp
  print "Image URL: "
  params["input_image_url"] = gets.chomp
  
  response = Unirest.patch("http://localhost:3000/products/#{input_id}", parameters: params)
  product = response.body

  if product["errors"]
    puts "Uh oh! Something went wrong..."
    p product["errors"]
  else
    puts "Here is your product"
    puts JSON.pretty_generate(product)
  end
elsif 
  user_input == "5"
  print "Print a product id: "
  input_id = gets.chomp
  response = Unirest.delete("http://localhost:3000/products/#{input_id}")
  body = response.body
  puts JSON.pretty_generate(body)
elsif 
  user_input == "6"
  params = {}

  print "Order quantity: "
  params["quantity"] = gets.chomp
  print "Print Order ID: "
  params["product_id"] = gets.chomp

  response = Unirest.post("http://localhost:3000/orders", parameters: params)
  body = response.body
  puts JSON.pretty_generate(body)
elsif user_input == "signup"
  params = {}
  print "Print Name: "
  params["name"] = gets.chomp
  print "Print Email: "
  params["email"] = gets.chomp
  print "Print Password: "
  params["password"] = gets.chomp
  print "Password Confirmation: "
  params["password_confirmation"] = gets.chomp


  response = Unirest.post("http://localhost:3000/users", parameters: params)
  user = response.body

  if user["errors"]
    p user["errors"]
  else
    puts "New User:"
    puts JSON.pretty_generate(user)
  end

end  


