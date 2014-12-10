class PointSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :description, :lat, :lng
end
