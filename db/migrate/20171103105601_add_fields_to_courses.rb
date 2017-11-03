class AddFieldsToCourses < ActiveRecord::Migration[5.0]
  def change
    add_attachment :courses, :transparent_logo
    add_column :courses, :logo_hyperlink, :string
  end
end
