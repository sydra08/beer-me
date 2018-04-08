class BreweryShowSerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :description
end
