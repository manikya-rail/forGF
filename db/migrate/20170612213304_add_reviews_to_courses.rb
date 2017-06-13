class AddReviewsToCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.float :overall_rating, default: 3
      t.float :value_rating, default: 3
      t.float :course_upkeep_rating, default: 3
      t.float :customer_service_rating, default: 3
      t.float :clubhouse_vibe_rating, default: 3
      t.string :text

      t.references :course, index: true
      t.references :user, index: true
      t.timestamps
    end
  end
end
