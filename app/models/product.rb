class Product < ApplicationRecord
  has_many :carted_products

  has_many :order

  has_many :category_products
  has_many :categories, through: :category_products

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
      supplier: self.supplier ? self.supplier.name : "no name",
      categories: self.categories.map {|category| category.name }
    }
  end
end


