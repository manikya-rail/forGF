class Hole < ApplicationRecord
    belongs_to :course
    # validates :par,:yards, :mhcp, :whcp, presence: true
    has_one :video
    has_one :score
    has_many :ads
    has_many :hole_image, :dependent => :destroy


    has_attached_file :image, styles: {
     thumb: '100x100>',
     square: '200x200#',
     medium: '300x300>'
   }

   # Validate the attached image is image/jpg, image/png, etc
   validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
