class BeerSerializer < ActiveModel::Serializer
  attributes :id, :name, :abv, :description
  belongs_to :brewery, serializer: BrewerySerializer
  belongs_to :category, serializer: CategorySerializer
end
