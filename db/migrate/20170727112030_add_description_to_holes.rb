class AddDescriptionToHoles < ActiveRecord::Migration[5.0]
  def change
    add_column :holes, :description, :text
  end
end
