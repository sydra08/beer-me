require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:each) do
    @brewery = create(:brewery)
    @category = create(:category)
    @beer = create(:beer, brewery: @brewery, category: @category)
  end

  describe 'test factory' do
    it "has a valid category factory with a name and description" do
      expect(build(:category).name).not_to be_blank
      expect(build(:category).description).not_to be_blank
    end
  end

  describe 'associations' do
    it 'has many beers' do
      expect(@category.beers).to include(@beer)
    end

    it 'has many breweries through beers' do
      expect(@category.breweries).to include(@brewery)
    end
  end
end
