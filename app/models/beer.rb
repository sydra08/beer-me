class Beer < ApplicationRecord
  validates :name, :category_id, :brewery_id, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
