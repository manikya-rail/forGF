class Ad < ApplicationRecord
	belongs_to :hole

	has_attached_file :image, styles: {
     thumb: '100x100>',
     square: '200x200#',
     medium: '300x300>'
   }
   validates_attachment_presence :image
   # Validate the attached image is image/jpg, image/png, etc
   validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
 
end
