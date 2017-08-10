class AddAttachmentImageToHoleImages < ActiveRecord::Migration
  def self.up
    change_table :hole_images do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :hole_images, :image
  end
end
