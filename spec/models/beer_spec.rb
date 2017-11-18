require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe 'test factory' do
    it "has a valid user factory with a name, description, brewery_id, category_id, and abv" do
      expect(build(:beer)).to be_valid
    end

    it 'has a creator'
  end

  describe 'validations' do
    it 'is invalid without a name' do
      expect(build(:beer, name: nil)).not_to be_valid
    end

    it 'is invalid without a category_id' do
      expect(build(:beer, category_id: nil)).not_to be_valid
    end
    
    it 'is invalid without a brewery_id' do
      expect(build(:beer, brewery_id: nil)).not_to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a brewery'
    it 'belongs to a category'
  end
end
