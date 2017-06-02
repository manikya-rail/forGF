class Amenity < ApplicationRecord
    belongs_to :course
    validates_uniqueness_of :course_id
end
