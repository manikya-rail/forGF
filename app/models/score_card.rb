class ScoreCard < ApplicationRecord

    belongs_to :course
    has_many :yardages, :dependent => :destroy
    has_many :pars, :dependent => :destroy
    has_many :hcps, :dependent => :destroy
    
    validates :tee_name, :color, :rating, :slope, presence: true
end
