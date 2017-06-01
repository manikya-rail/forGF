class Video < ApplicationRecord

    belongs_to :hole
    has_many :tags
    has_attached_file :video, styles: {
    :medium => {
      :geometry => "640x480",
      :format => 'mp4',
      bucket: 'fore',
      :s3_credentials => {
        :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
      }
    }}, :processors => [:transcoder]

    validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/
end
