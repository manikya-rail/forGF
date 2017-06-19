class AddListRefToCourses < ActiveRecord::Migration[5.0]
  def change
    add_reference :courses, :list, foreign_key: true
  end
end
