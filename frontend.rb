require "unirest"

system "clear"

respose = Unirest.get("http://localhost:3000/sergii_all_products")
products = respose.body



#puts JSON.pretty_generate(products)

def all_ids 
  respose = Unirest.get("http://localhost:3000/sergii_all_products")
  products = respose.body
  products.each do |hash|
    puts "Product id #{hash["id"]}"
  end
end

all_ids