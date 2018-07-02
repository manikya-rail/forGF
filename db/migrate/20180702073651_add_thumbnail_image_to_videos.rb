class AddThumbnailImageToVideos < ActiveRecord::Migration[5.0]
  def up
      add_attachment :videos, :thumbnail_image
    end

    def down
      remove_attachment :videos, :thumbnail_image
    end
end
