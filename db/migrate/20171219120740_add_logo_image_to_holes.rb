class AddLogoImageToHoles < ActiveRecord::Migration[5.0]
  def change
  	add_attachment :holes, :logo_image
  end
end
