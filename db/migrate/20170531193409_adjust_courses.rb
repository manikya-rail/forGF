class AdjustCourses < ActiveRecord::Migration[5.0]
  def change
    change_column :courses, :slope, 'float USING CAST(slope AS float)'
    change_column :courses, :rating, 'float USING CAST(rating AS float)'
  end
end
