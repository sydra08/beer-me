require 'rails_helper'

RSpec.describe Brewery, type: :model do
  describe 'test factory' do
    it "has a valid brewery factory with a name, description, and location" do
      expect(build(:brewery).name).not_to be_blank
      expect(build(:brewery).description).not_to be_blank
      expect(build(:brewery).location).not_to be_blank
      expect(build(:beer)).to be_valid
    end

    it 'has a creator'
  end

  describe 'associations' do
    it 'has many beers'
    it 'has many categories through beers'
  end
end
