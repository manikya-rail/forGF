class ChangeDataTypeForLatLng < ActiveRecord::Migration[5.0]
  def change
  	change_column(:locations, :lat, :float)
  	change_column(:locations, :lng, :float)
  end
end
