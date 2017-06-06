class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.string :name
      t.references :user, index: true
      t.references :courses, index: true
      t.timestamps
    end
  end
end
