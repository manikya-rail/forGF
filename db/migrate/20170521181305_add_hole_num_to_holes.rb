class AddHoleNumToHoles < ActiveRecord::Migration[5.0]
  def change
    add_column :holes, :hole_num, :integer
  end
end
