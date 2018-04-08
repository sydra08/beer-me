class BrewerySerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :description
end
