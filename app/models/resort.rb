class Resort < ApplicationRecord
    has_many :courses, :dependent => :destroy
    has_one :location, :dependent => :destroy

    accepts_nested_attributes_for :location, :allow_destroy => true
    accepts_nested_attributes_for :courses
end
