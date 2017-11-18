require 'rails_helper'

RSpec.describe Beer, type: :model do
  before(:each) do
    @brewery = create(:brewery)
    @category = create(:category)
    @beer = create(:beer, brewery: @brewery, category: @category)
    @user = create(:user)
    @user_beer = create(:user_beer, user: @user, beer: @beer, status: true)
  end
  
  describe 'test factory' do
    it "has a valid beer factory with a name, description, brewery_id, category_id, and abv" do

      expect(@beer.description).not_to be_blank
      expect(@beer.abv).not_to be_blank
      expect(build(:beer)).to be_valid
    end

    it 'has a creator'
  end

  describe 'validations' do
    it 'is invalid without a name, category_id, and brewery_id' do
      expect(build(:beer, name: nil)).not_to be_valid
      expect(build(:beer, category_id: nil)).not_to be_valid
      expect(build(:beer, brewery_id: nil)).not_to be_valid
    end

    it 'has a unique name, case insensitive' do
      beer1 = create(:beer, name: "Avery White Rascal")
      beer2 = build(:beer, name: "avery white rascal")
      beer3 = build(:beer, name: "AVERY WHITE RASCAL")

      expect(beer2).not_to be_valid
      expect(beer2.errors.full_messages).to include("Name has already been taken")
      expect(beer3).not_to be_valid
      expect(beer3.errors.full_messages).to include("Name has already been taken")
    end
  end

  describe 'associations' do

    it 'belongs to a brewery' do
      expect(@beer.brewery).to eq(@brewery)
    end

    it 'belongs to a category' do
      expect(@beer.category).to eq(@category)
    end

    it 'has many user_beers' do
      expect(@beer.user_beers).to include(@user_beer)
    end
  end
end
