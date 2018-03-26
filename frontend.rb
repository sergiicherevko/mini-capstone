# 9) Add a frontend option to order all items in the shopping cart (the orders create action)

# 10) Add a carted products destroy action. This shouldn’t destroy the carted product - it should instead just update the status to “removed”.

# 11) Add a frontend option to remove an item from the cart (the carted products destroy action)

require "unirest"
# Authorisation
system "clear"
puts "[signup] Signup (create new user)"
puts "[login] Log in (if created user)"
puts "[logout] Log out (if signed up user)"

user_input = gets.chomp

if 
  user_input == "signup"
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
elsif 
  user_input == "login"
  print "Print email: "
  email = gets.chomp
  print "Print password: "
  password = gets.chomp
  response = Unirest.post(
  "http://localhost:3000/user_token",
  parameters: {
    auth: {
      email: "#{email}",
      password: "#{password}"
      }
    }
  )
  jwt = response.body["jwt"]
  Unirest.default_header("Authorization", "Bearer #{jwt}")
elsif 
  user_input == "logout"
  jwt = ""
  Unirest.clear_default_headers() 
end   

# Application
exit = 0
while exit == 0

  system "clear"
  p jwt
  puts "Welcome to Product app! Choose an option:"


  puts "[1] See all products"
  puts "  [1.1] Search for product"
  puts "  [1.2] Sort by name"
  puts "[2] See one product"
  puts "[3] Create a product"
  puts "[4] Update a product"
  puts "[5] Delete a product"

  puts "[6] Add to cart"
  puts "[7] See all carted products"
  puts "[8] Check out (make an order)"

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

    response = Unirest.post("http://localhost:3000/carted_products", parameters: params)
    body = response.body
    puts JSON.pretty_generate(body)
  elsif 
    user_input == "7"
    respose = Unirest.get("http://localhost:3000/carted_products")
    carted_products = respose.body 
    puts JSON.pretty_generate(carted_products)
  elsif 
    user_input == "8"
    respose = Unirest.post("http://localhost:3000/orders")
    order = respose.body
    puts JSON.pretty_generate(order)
  end  

 #Exit option
  puts "Continue? (type 'no' for exit)."
  user_decision = gets.chomp
  if user_decision == "no"
    exit = 1
    system "clear"
  end
end