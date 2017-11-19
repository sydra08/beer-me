require 'rails_helper'

RSpec.describe Brewery, type: :model do
  before(:each) do
    @brewery = create(:brewery)
    @category = create(:category)
    @beer = create(:beer, brewery: @brewery, category: @category)
  end

  describe 'test factory' do
    it "has a valid brewery factory with a name, description, and location" do
      expect(build(:brewery).description).not_to be_blank
      expect(build(:brewery).location).not_to be_blank
      expect(build(:brewery)).to be_valid
    end

    it 'has a creator'
  end

  describe 'validations' do
    it 'is invalid without a name' do
      expect(build(:brewery, name: nil)).not_to be_valid
    end

    it 'has a unique name, case insensitive' do
      brewery = create(:brewery, name: "Avery Brewing Co")
      expect(build(:brewery, name: "avery brewing co")).not_to be_valid
      expect(build(:brewery, name: "AVERY BREWING CO")).not_to be_valid
    end

  end

  describe 'associations' do
    it 'has many beers' do
      expect(@brewery.beers).to include(@beer)
    end

    it 'has many categories through beers' do
      expect(@brewery.categories).to include(@category)
    end
  end
end
