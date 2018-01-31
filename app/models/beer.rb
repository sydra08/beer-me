class Beer < ApplicationRecord
  belongs_to :category
  belongs_to :brewery
  has_many :user_beers

  validates :name, uniqueness: { case_sensitive: false }, presence: true
  validates :abv, numericality: { less_than_or_equal_to: 100.00 }

  scope :by_category_and_brewery, ->(category_id, brewery_id) { where("category_id = ? AND brewery_id = ?", category_id, brewery_id) }

  scope :by_category, ->(category_id) { where(category: category_id) }

  scope :by_brewery, ->(brewery_id) { where(brewery: brewery_id) }

  def brewery_attributes=(brewery_attributes)
    self.brewery = Brewery.find_or_create_by(name: brewery_attributes[:name])
    self.brewery.update(location: brewery_attributes[:location])
  end

  def category_attributes=(category_attributes)
    self.category = Category.find_or_create_by(name: category_attributes[:name])
  end

  def self.alpha_sorted
    order(name: :asc)
  end

  def self.sort_by_brewery
    joins(:brewery).order("breweries.name")
  end

  def brewery_name
    brewery.name
  end

end
