class Beer < ApplicationRecord
  belongs_to :category
  belongs_to :brewery
  has_many :user_beers

  validates :name, uniqueness: { case_sensitive: false }, presence: true
  validates :abv, numericality: { less_than_or_equal_to: 100.00 }
  # custom setters for brewery and category so that dupes are avoided

  # instead of a validation on the model, maybe just in the controller for now?
  # def not_same_brewery
  #   # if name already exists
  #     # does brewery exist?
  #       # if not, create beer
  #       # otherwise don't create beer
  # end


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

  # def self.by_category_and_brewery(category_id, brewery_id)
  #   where("category_id = ? AND brewery_id = ?", category_id, brewery_id)
  # end
  #
  # def self.by_category(category_id)
  #   where(category: category_id)
  # end
  #
  # def self.by_brewery(brewery_id)
  #   where(brewery: brewery_id)
  # end
  #
  # 
  # def self.by_user_and_brewery_and_category(user_id, brewery_id, category_id)
  #   Beer.joins(:user_beers).group("user_beers.user_id").having("beers.brewery_id = ? AND beers.category_id = ? AND user_beers.user_id = ?", brewery_id, category_id, user_id)
  # end
  #
  # def self.by_user_and_category(user_id, category_id)
  #   Beer.joins(:user_beers).group("user_beers.user_id").having("beers.category_id = ? AND user_beers.user_id = ?", category_id, user_id)
  # end
  #
  # def self.by_user_and_brewery(user_id, brewery_id)
  #   Beer.joins(:user_beers).group("user_beers.user_id").having("beers.brewery_id = ? AND user_beers.user_id = ?", brewery_id, user_id)
  # end
end
