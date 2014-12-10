class Point < ActiveRecord::Base
  belongs_to :user
  geocoded_by :location, :latitude => :lat, :longitude => :lng
  after_validation :geocode
end
