class UserBeerSerializer < ActiveModel::Serializer
  attributes :id, :notes, :status
  belongs_to :beer, serializer: BeerSerializer
  belongs_to :user, serializer: UserSerializer
end
