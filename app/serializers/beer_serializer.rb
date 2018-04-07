class BeerSerializer < ActiveModel::Serializer
  attributes :id, :name, :abv, :description
  belongs_to :brewery
  belongs_to :category
end
