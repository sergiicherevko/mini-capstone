class AddStatusToCategoryProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :category_products, :status, :string
  end
end
