class CourseImage < ApplicationRecord
  belongs_to :course

  has_attached_file :photo, styles: {
     thumb: '100x100>',
     square: '200x200#',
     medium: '300x300>'
   }
  do_not_validate_attachment_file_type :photo

  # validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
