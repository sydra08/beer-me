class UserBeer < ApplicationRecord
  belongs_to :user
  belongs_to :beer

  def verbose_status
    new_status = ''
    if status
      new_status = "Tried"
    else
      new_status = "Want to try"
    end
    new_status
  end

  def self.by_user_and_brewery_and_category(user_id, brewery_id, category_id)
    UserBeer.where(user_id: user_id).joins(:beer).where("beers.brewery_id = ? AND beers.category_id = ?", brewery_id, category_id)
  end

  def self.by_user_and_category(user_id, category_id)
    UserBeer.where(user_id: user_id).joins(:beer).where("beers.category_id = ?", category_id)
  end

  def self.by_user_and_brewery(user_id, brewery_id)
    UserBeer.where(user_id: user_id).joins(:beer).where("beers.brewery_id = ?", brewery_id)
  end

  def self.by_user(user_id)
    UserBeer.where(user_id: user_id)
  end

  # def self.alpha_sorted
  #   joins(:beer).order("beers.name")
  # end

  def self.sort_by_brewery
    joins(beer: :brewery).order("breweries.name")
  end

end
