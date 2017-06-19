class AddHoleIdToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :hole_id, :integer
  end
end
