class AddFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :gender, :integer
    add_attachment :users, :picture
    add_column :users, :location, :string
    add_column :users, :home_courses, :string
    add_column :users, :handicap_value, :string
  end
end
