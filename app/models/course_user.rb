class CourseUser < ApplicationRecord
  belongs_to :course
  belongs_to :user

  validates_uniqueness_of :course_id, :scope => :user_id
end
