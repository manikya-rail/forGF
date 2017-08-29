class AddAttachmentPhotoToCourseImages < ActiveRecord::Migration
  def self.up
    change_table :course_images do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :course_images, :photo
  end
end
