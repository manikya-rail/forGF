class AdjustLists < ActiveRecord::Migration[5.0]
  def change
    remove_index :lists, :courses_id
    remove_column :lists, :courses_id
    add_reference :lists, :course, foreign_key: true
  end
end
