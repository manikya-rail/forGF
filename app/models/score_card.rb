class ScoreCard < ApplicationRecord

    belongs_to :course
    has_many :yardages, :dependent => :destroy
    has_many :pars, :dependent => :destroy
    has_many :hcps, :dependent => :destroy
    
    validates :tee_name, :color, :rating, :slope, presence: true

    def total_par
    	self.pars.pluck(:par).compact.sum
    end

    def total_yards
    	self.yardages.pluck(:yards).compact.sum
    end

    def get_yards_data
    	scorecard_yards = self.yardages.order("hole_id").map(&:yards)
    	scorecard_yards_data = scorecard_yards.first(9)
    	scorecard_yards_data << scorecard_yards.first(9).compact.sum
    	scorecard_yards_data << scorecard_yards.last(9)
    	scorecard_yards_data << scorecard_yards.last(9).compact.sum
    	scorecard_yards_data << total_yards
    	scorecard_yards_data.flatten!
    	scorecard_yards_data
    end

    def get_pars_data
    	scorecard_pars = self.pars.order("hole_id").map(&:par)
    	scorecard_pars_data = scorecard_pars.first(9)
    	scorecard_pars_data << scorecard_pars.first(9).compact.sum
    	scorecard_pars_data << scorecard_pars.last(9)
    	scorecard_pars_data << scorecard_pars.last(9).compact.sum
    	scorecard_pars_data << total_par
    	scorecard_pars_data.flatten!
    	scorecard_pars_data
    end

    def get_hcps_data
    	scorecard_hcps = self.hcps.order("hole_id").map(&:hcp)
    	scorecard_hcps_data = scorecard_hcps.first(9)
    	scorecard_hcps_data << ""
    	scorecard_hcps_data << scorecard_hcps.last(9)
    	scorecard_hcps_data << ""
    	scorecard_hcps_data << ""
    	scorecard_hcps_data.flatten!
    	scorecard_hcps_data
    end
end
