class Brewery < ApplicationRecord
  has_many :beers
  has_many :categories, through: :beers

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  def by_category(category_id)
    beers.where(category: category_id)
  end

  def self.alpha_sorted
    order(name: :asc)
  end

  def self.by_colorado
    where("location = ?", "Fort Collins, CO")
  end
end
