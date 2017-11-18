class Brewery < ApplicationRecord
  validates :name, :location, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
