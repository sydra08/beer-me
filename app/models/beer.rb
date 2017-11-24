class Beer < ApplicationRecord
  belongs_to :category
  belongs_to :brewery
  has_many :user_beers

  validates :name, uniqueness: { case_sensitive: false }, presence: true

  # custom setters for brewery and category so that dupes are avoided

  def brewery_name=(name)
    # figure out how to write a proper where statement
    self.brewery = Brewery.find_or_create_by(name: name)
  end

  def category_name=(name)
    self.category = Category.find_or_create_by(name: name)
  end

  def brewery_name
    self.brewery.name if self.brewery
  end

  def category_name
    self.category.name if self.category
  end

end
