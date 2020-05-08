class Resort < ApplicationRecord

	include PgSearch
	pg_search_scope :search_by_name, :against => [:name]
	
    has_many :courses, :dependent => :destroy
    has_one :location, :dependent => :destroy

    accepts_nested_attributes_for :location, :allow_destroy => true
    accepts_nested_attributes_for :courses

    has_attached_file :logo, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
    }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

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
