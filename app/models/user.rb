class User < ApplicationRecord

  include PgSearch
  pg_search_scope :search_by_name, :against => [:first_name, :last_name]

  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :lists
  has_many :reviews
  has_many :scores
  has_many :course_users
  has_many :courses, through: :course_users

  enum gender: [:female, :male]

  has_attached_file :picture, styles: {
   thumb: '100x100>',
   square: '200x200#',
   medium: '300x300>'
 }

 # Validate the attached image is image/jpg, image/png, etc
 validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  def name
      first_name.to_s + " " + last_name.to_s
  end
end
