require 'rails_helper'

RSpec.describe UserBeer, type: :model do
  before(:each) do
    @brewery = create(:brewery)
    @category = create(:category)
    @beer = create(:beer, brewery: @brewery, category: @category)
    @user = create(:user)
    @user_beer = create(:user_beer, user: @user, beer: @beer, status: true)
  end

  describe 'test factory' do
    it "has a valid user beer factory with a user_id, beer_id, and status" do
      expect(@user_beer).to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      expect(@user_beer.user).to eq(@user)
    end
    it 'belongs to a beer' do
      expect(@user_beer.beer).to eq(@beer)
    end
  end
end
