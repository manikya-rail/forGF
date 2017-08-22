class CreateHoleImages < ActiveRecord::Migration[5.0]
  def change
    create_table :hole_images do |t|
      t.references :hole, foreign_key: true

      t.timestamps
    end
  end
end
