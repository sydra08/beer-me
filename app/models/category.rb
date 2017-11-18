class Category < ApplicationRecord
  has_many :beers
  has_many :breweries, through: :beers
end
