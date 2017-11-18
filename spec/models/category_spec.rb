require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'has many beers' do
    Category.first.beers << Beer.first
    expect(Category.first.beers).to include(Beer.first)
  end
end
