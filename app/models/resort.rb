class Resort < ApplicationRecord

	include PgSearch
	pg_search_scope :search_by_name, :against => [:name]
	
    has_many :courses, :dependent => :destroy
    has_one :location, :dependent => :destroy

    accepts_nested_attributes_for :location, :allow_destroy => true
    accepts_nested_attributes_for :courses

    def formated_location
      formated_location_result = ""
      town = self.location.try(:town)
      state = self.location.try(:state)
      lat = self.location.try(:lat)
      lng = self.location.try(:lng)

      formated_location_result << town  if town
      formated_location_result << ", " + state if state

      formated_location_result
    end
end
