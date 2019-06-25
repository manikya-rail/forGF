class AddHideLogoToResorts < ActiveRecord::Migration[5.0]
  def change
    add_column :resorts, :hide_logo, :boolean
  end
end
