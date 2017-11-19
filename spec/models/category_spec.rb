require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'test factory' do
    it "has a valid category factory with a name and description" do
      expect(build(:category).description).not_to be_blank
      expect(build(:category)).to be_valid
    end
  end

  describe 'validations' do
    it 'is invalid without a name' do
      expect(build(:category, name: nil)).not_to be_valid
    end

    it 'has a unique name, case insensitive' do
      cat1 = create(:category, name: "India Pale Ale")
      cat2 = build(:category, name: "india pale ale")
      cat3 = build(:category, name: "INDIA PALE ALE")

      expect(cat2).not_to be_valid
      expect(cat2.errors.full_messages).to include("Name has already been taken")
      expect(cat3).not_to be_valid
      expect(cat3.errors.full_messages).to include("Name has already been taken")
    end

    it 'has a creator'
  end

  describe 'associations' do
    before do
      @brewery = create(:brewery)
      @category = create(:category)
      @beer = create(:beer, brewery: @brewery, category: @category)
    end

    it 'has many beers' do
      expect(@category.beers).to include(@beer)
    end

    it 'has many breweries through beers' do
      expect(@category.breweries).to include(@brewery)
    end
  end
end
