class AddRankToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :rank, :integer
  end
end
