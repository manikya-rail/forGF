class AddStatusToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :status, :string
  end
end
