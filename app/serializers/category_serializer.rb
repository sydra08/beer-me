class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :beer_count, :description
end
