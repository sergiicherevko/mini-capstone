class DeleteStatusToCategoryProducts < ActiveRecord::Migration[5.1]
  def change
    remove_column :category_products, :status, :string
  end
end
