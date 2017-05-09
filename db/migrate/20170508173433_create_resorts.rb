class CreateResorts < ActiveRecord::Migration[5.0]
  def change
    create_table :resorts do |t|
      t.string :name
      t.references :course, index: true
      t.timestamps
    end
  end
end
