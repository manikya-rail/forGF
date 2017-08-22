class ScoreCard < ApplicationRecord

    belongs_to :course
    has_many :yardages
    
    validates :tee_name, :color, presence: true
end
