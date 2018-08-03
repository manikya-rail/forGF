class AddRankToHoleImages < ActiveRecord::Migration[5.0]
  def change
    add_column :hole_images, :rank, :integer
  end
end
