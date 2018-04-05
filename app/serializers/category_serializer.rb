class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :beer_count
  has_many :beers
end
