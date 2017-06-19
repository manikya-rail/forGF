class ScoreCard < ApplicationRecord
    belongs_to :course
    validates :tee_name, :color, presence: true
end
