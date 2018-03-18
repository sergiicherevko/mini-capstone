class Product < ApplicationRecord
  validates :name, uniqueness: true
  validates :price, presence: true
  validates :description, length: { in: 1..500 }

  def is_discounted
    if 
      self.price < 500 
    end
  end

  def supplier
    Supplier.find_by(id: self.supplier_id)
  end

  def tax
    "Tax: #{self.price * 0.09}"
  end

  def total
    "Total: #{self.price * 0.09 + self.price}"
  end

  def as_json
    {
      id: self.id,
      name: self.name,
      price: self.price,
      image_url: self.image_url,
      description: self.description,
      supplier: self.supplier
    }
  end

end

# Change your app to show the supplier’s info with each product.