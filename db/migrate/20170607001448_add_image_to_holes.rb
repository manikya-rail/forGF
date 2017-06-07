class AddImageToHoles < ActiveRecord::Migration[5.0]
  def change
    add_attachment :holes, :image
  end
end
