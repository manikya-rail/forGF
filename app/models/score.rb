class Score < ApplicationRecord
  validates :score, presence: true
  validates_uniqueness_of :hole_id

  belongs_to :user
  belongs_to :hole
end
