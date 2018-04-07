class BrewerySerializer < ActiveModel::Serializer
  attributes :id, :name, :location, :description
  has_many :beers
end
