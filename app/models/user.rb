class User < ApplicationRecord

  include PgSearch
  pg_search_scope :search_by_name, :against => [:first_name, :last_name]
    
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def name
      first_name.to_s + " " + last_name.to_s
  end
end
