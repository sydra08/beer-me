class BeerSerializer < ActiveModel::Serializer
  attributes :id, :name, :abv, :description
  belongs_to :brewery, serializer: BreweryListSerializer
  belongs_to :category, serializer: CategoryListSerializer
end
