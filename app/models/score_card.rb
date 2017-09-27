class ScoreCard < ApplicationRecord

    belongs_to :course
    has_many :yardages, :dependent => :destroy
    
    validates :tee_name, :color, presence: true
end
