class BeerSerializer < ActiveModel::Serializer
  attributes :id, :name, :abv
  belongs_to :brewery
end
