class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :town
      t.string :state
      t.integer :lat
      t.integer :lng
      t.references :course, index: true

      t.timestamps
    end
  end
end
