class Hole < ApplicationRecord
    belongs_to :course
    # validates :par,:yards, :mhcp, :whcp, presence: true
    has_one :video
    has_one :score
    has_many :ads
    has_many :yardages, :dependent => :destroy
    has_many :hole_image, :dependent => :destroy


    accepts_nested_attributes_for :yardages, :allow_destroy => true


    has_attached_file :image, styles: {
     thumb: '100x100>',
     square: '200x200#',
     medium: '300x300>'
   }

   has_attached_file :map, styles: {
     thumb: '100x100>',
     square: '200x200#',
     medium: '300x300>'
   }
   has_attached_file :logo_image, styles: {
     thumb: '100x100>',
     square: '200x200#',
     medium: '300x300>'
   }

   # Validate the attached image is image/jpg, image/png, etc
   validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
   validates_attachment_content_type :map, :content_type => /\Aimage\/.*\Z/
   validates_attachment_content_type :logo_image, :content_type => /\Aimage\/.*\Z/
end
