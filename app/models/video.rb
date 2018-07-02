class Video < ApplicationRecord
  belongs_to :videoable, polymorphic: true
  has_many :tags
  has_attached_file :video, styles: {
    :medium => {
      :geometry => "1920x1080",
      :format => 'mp4'
    },
    :mobile => {
      :geometry => "750x422>",
      :format => 'mp4'
    }
  }, :processors => [:transcoder]

  has_attached_file :thumbnail_image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  validates_attachment_content_type :video, content_type: /\Avideo\/.*\Z/
  validates_attachment_content_type :thumbnail_image, :content_type => /\Aimage\/.*\Z/
end
