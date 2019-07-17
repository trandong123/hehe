class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :img_url
      t.float :price
      t.float :rating_avg
      t.integer :rate_count
      t.references :food_category, foreign_key: true

      t.timestamps
    end
  end
end
