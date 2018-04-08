class UserSerializer < ActiveModel::Serializer
  attributes :id
  has_many :userbeers, serializer: UserBeerSerializer
  has_many :beers, serializer: BeerSerializer
end
