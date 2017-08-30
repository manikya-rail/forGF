class AddVideoToCourse < ActiveRecord::Migration[5.0]
  def change
    add_attachment :courses, :video
  end
end
