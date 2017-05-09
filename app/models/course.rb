class Course < ApplicationRecord
     has_one :amenity
     has_many :holes
     has_one :location
     has_many :networks
     has_many :resorts
     has_many :score_cards
     belongs_to :admin

     accepts_nested_attributes_for :location, :allow_destroy => true
     accepts_nested_attributes_for :networks, :allow_destroy => true
     accepts_nested_attributes_for :resorts, :allow_destroy => true
     accepts_nested_attributes_for :score_cards, :allow_destroy => true
     accepts_nested_attributes_for :holes, :allow_destroy => true
     accepts_nested_attributes_for :amenity, :allow_destroy => true

end
