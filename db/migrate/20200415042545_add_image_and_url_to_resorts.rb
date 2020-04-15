class AddImageAndUrlToResorts < ActiveRecord::Migration[5.0]
  def change
  	add_attachment :resorts, :logo
  	add_column :resorts, :lead_url, :string
  end
end
