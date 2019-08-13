class Hole < ApplicationRecord
    belongs_to :course
    # validates :par,:yards, :mhcp, :whcp, presence: true
    has_one :video, as: :videoable
    has_one :score
    has_many :ads
    has_many :yardages, :dependent => :destroy
    has_many :pars, :dependent => :destroy
    has_many :hcps, :dependent => :destroy
    has_many :hole_images, :dependent => :destroy


    accepts_nested_attributes_for :yardages, :allow_destroy => true


    has_attached_file :image, styles: {
     thumb: '100x100>',
     square: '200x200#',
     medium: '300x300>'
   }

   has_attached_file :map, styles: {
     thumb: '100x100>',
     square: '200x200#',
     medium: '300x300>'
   }
   has_attached_file :logo_image, styles: {
     thumb: '100x100>',
     square: '200x200#',
     medium: '300x300>'
   }

   # Validate the attached image is image/jpg, image/png, etc
   validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
   validates_attachment_content_type :map, :content_type => /\Aimage\/.*\Z/
   validates_attachment_content_type :logo_image, :content_type => /\Aimage\/.*\Z/

  def total_yards
    first_scorecard = course_first_scorecard
    if first_scorecard
      self.yardages.find_by(score_card_id: first_scorecard.id).try(:yards)
      #self.yardages.pluck(:yards).compact.sum
    end
  end

  def total_pars
    first_scorecard = course_first_scorecard
    if first_scorecard
      self.pars.find_by(score_card_id: first_scorecard.id).try(:par)
      #self.pars.pluck(:par).compact.sum
    end
  end

  def total_hcps
    first_scorecard = course_first_scorecard
    if first_scorecard
      self.hcps.find_by(score_card_id: first_scorecard.id).try(:hcp)
      #self.hcps.pluck(:hcp).compact.sum
    end
  end

  def course_first_scorecard
    first_scorecard = self.course.score_cards.order(:rank).first unless self.course.score_cards.pluck(:rank).compact.blank?
    first_scorecard = self.course.score_cards.first if first_scorecard.nil?
    first_scorecard 
  end
end
