class Course < ApplicationRecord

     include PgSearch
     pg_search_scope :search_by_name, :against => [:name]
     
     has_one :amenity
     has_many :holes
     has_one :location

     belongs_to :network
     belongs_to :resort
     
     has_many :score_cards
     belongs_to :admin

     accepts_nested_attributes_for :location, :allow_destroy => true
     accepts_nested_attributes_for :score_cards, :allow_destroy => true
     accepts_nested_attributes_for :holes, :allow_destroy => true
     accepts_nested_attributes_for :amenity, :allow_destroy => true
     validates_presence_of :name,:bio, :website, :phone_num, :total_par, :slope, :rating, :length


     def formated_location
          formated_location_result = ""
          town = self.location.try(:town)
          state = self.location.try(:state)
          lat = self.location.try(:lat)
          lng = self.location.try(:lng)

          formated_location_result << town  if town
          formated_location_result << ", " + state if state
          formated_location_result << " " +  "(lat: #{ lat },lng: #{ lng })" if lat and lng

          formated_location_result   
     end

     def resorts_names
          self.resorts.pluck(:name).join(',')        
     end

     def networks_names
          self.networks.pluck(:name).join(',')     
     end

end
