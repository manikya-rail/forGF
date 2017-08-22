class AddAttachmentMapToHoles < ActiveRecord::Migration
  def self.up
    change_table :holes do |t|
      t.attachment :map
    end
  end

  def self.down
    remove_attachment :holes, :map
  end
end
