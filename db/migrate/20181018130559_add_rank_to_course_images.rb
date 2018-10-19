class AddRankToCourseImages < ActiveRecord::Migration[5.0]
  def change
    add_column :course_images, :rank, :integer
  end
end
