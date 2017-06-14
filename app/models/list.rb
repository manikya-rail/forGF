class List < ApplicationRecord
  belongs_to :user
  has_many :courses

  validates_uniqueness_of :course_id, :scope => :user_id
end
