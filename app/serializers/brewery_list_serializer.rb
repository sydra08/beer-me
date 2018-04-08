class BreweryListSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :beers
end
