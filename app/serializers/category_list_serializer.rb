class CategoryListSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :beers
end
