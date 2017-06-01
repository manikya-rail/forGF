class Video < ApplicationRecord

    belongs_to :hole
    has_many :tags
    has_attached_file :video, styles: {
    :medium => {
      :geometry => "640x480",
      :format => 'mp4'
    }}, :processors => [:transcoder]

    validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/
end
