class AddExtraDetailsToResorts < ActiveRecord::Migration[5.0]
  def change
  	add_column :resorts, :resort_type, :string
  	add_column :resorts, :website, :string
  	add_column :resorts, :phone_num, :string
  	add_column :resorts, :network_id, :integer
  	add_column :resorts, :courses_count, :integer
  end
end
