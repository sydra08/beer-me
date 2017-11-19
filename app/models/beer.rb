class Beer < ApplicationRecord
  belongs_to :category
  belongs_to :brewery
  has_many :user_beers

  validates :name, :brewery_id, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
