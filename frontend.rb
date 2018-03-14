require "unirest"

system "clear"

puts "Welcome to Product app! Choose an option:"
puts "[1] See all products"
puts "[2] See one product"
puts "[3] Create a product"
puts "[4] Update a product"
puts "[5] Delete a product"

user_input = gets.chomp.to_i

if 
  user_input == 1
  respose = Unirest.get("http://localhost:3000/products")
  products = respose.body
  puts JSON.pretty_generate(products)
elsif 
  user_input == 2  
  print "Print products id:"
  user_input_id = gets.chomp.to_i
  response = Unirest.get("http://localhost:3000/products/#{user_input_id}")
  product = response.body
  puts JSON.pretty_generate(product)
elsif
  user_input == 3
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
    "input_description" => input_description
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
  user_input == 4
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
  body = response.body
  puts JSON.pretty_generate(body)
elsif 
  user_input == 5
  print "Print a product id: "
  input_id = gets.chomp
  response = Unirest.delete("http://localhost:3000/products/#{input_id}")
  body = response.body
  puts JSON.pretty_generate(body)
end  


