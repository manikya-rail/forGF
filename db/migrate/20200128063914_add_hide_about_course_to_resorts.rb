class AddHideAboutCourseToResorts < ActiveRecord::Migration[5.0]
  def change
    add_column :resorts, :hide_about_course, :boolean
  end
end
