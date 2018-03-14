class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :image_url
      t.string :description

      t.timestamps
    end
  end
end


# Exercise: Make changes to your Mini-Capstone App
# • Your description attribute may currently use the wrong data-type(string). Update it with the correct one if needed.
# • Update the price attribute with the correct data-type. Be mindful of the correct number digits your type of products require.
# • Bonus: Add an attribute you can use to describe if the product is in-stock or out-of-stock.
