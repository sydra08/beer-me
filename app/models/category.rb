class Category < ApplicationRecord
  has_many :beers
  has_many :breweries, through: :beers

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  def by_brewery(brewery_id)
    beers.where(brewery: brewery_id)
  end

  def self.alpha_sorted
    order(name: :asc)
  end

  def beer_count
    beers.count
  end
  
end
