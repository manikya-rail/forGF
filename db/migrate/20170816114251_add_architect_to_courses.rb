class AddArchitectToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :architect, :string
  end
end
