class AddLogoAndCoverToCourses < ActiveRecord::Migration[5.0]
  def change
    add_attachment :courses, :logo
    add_attachment :courses, :cover
  end
end
