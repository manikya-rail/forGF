class Location < ApplicationRecord
    belongs_to :course
     validates :state, :town, :lat, :lng,  presence: true

end
