class List < ApplicationRecord
  belongs_to :user
  has_many :courses
  validates_uniqueness_of :courses_id
end
