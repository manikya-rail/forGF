class AddColumnsToAmenities < ActiveRecord::Migration[5.0]
  def change
    add_column :amenities, :practice_range, :boolean
    add_column :amenities, :golf_boards, :boolean
  end
end
