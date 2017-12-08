class AddColorSelectorToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :color_selector, :string
  end
end
