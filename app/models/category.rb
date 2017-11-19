class Category < ApplicationRecord
  has_many :beers
  has_many :breweries, through: :beers

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
