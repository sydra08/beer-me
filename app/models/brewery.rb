class Brewery < ApplicationRecord
  has_many :beers
  has_many :categories, through: :beers

  validates :name, :location, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
