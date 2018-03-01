class AddAttachmentPhotoToScorecardImage < ActiveRecord::Migration[5.0]
  def change
    add_attachment :scorecard_images, :photo
  end
end
