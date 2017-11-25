class Beer < ApplicationRecord
  belongs_to :category
  belongs_to :brewery
  has_many :user_beers

  validates :name, uniqueness: { case_sensitive: false }, presence: true

  # custom setters for brewery and category so that dupes are avoided

  def brewery_attributes=(brewery_attributes)
    self.brewery = Brewery.find_or_create_by(name: brewery_attributes[:name])
    self.brewery.update(location: brewery_attributes[:location])
  end

  def category_attributes=(category_attributes)
    self.category = Category.find_or_create_by(name: category_attributes[:name])
  end

end
