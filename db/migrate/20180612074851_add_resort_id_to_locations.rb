class AddResortIdToLocations < ActiveRecord::Migration[5.0]
  def change
    add_column :locations, :resort_id, :integer
  end
end
