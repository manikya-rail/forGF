class Yardage < ApplicationRecord
  belongs_to :ScoreCard
  belongs_to :Hole
end
