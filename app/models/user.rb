class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  geocoded_by :home_city,  :latitude => :lat, :longitude => :lng
  after_validation :geocode
  has_many :trips
  has_many :points


end
