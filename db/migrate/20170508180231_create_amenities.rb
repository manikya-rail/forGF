class CreateAmenities < ActiveRecord::Migration[5.0]
  def change
    create_table :amenities do |t|
      t.boolean :restaurants
      t.boolean :caddies
      t.boolean :carts
      t.references :course, index: true
      t.timestamps
    end
  end
end
