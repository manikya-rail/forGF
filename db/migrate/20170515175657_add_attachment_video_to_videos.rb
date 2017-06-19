class AddAttachmentVideoToVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.attachment :video
    end
  end

  
end
