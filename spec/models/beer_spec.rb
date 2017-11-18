require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe 'test factory' do
    it "has a valid beer factory with a name, description, brewery_id, category_id, and abv" do
      beer = create(:beer)

      expect(beer.name).not_to be_blank
      expect(beer.description).not_to be_blank
      expect(beer.brewery_id).not_to be_blank
      expect(beer.category_id).not_to be_blank
      expect(beer.abv).not_to be_blank
      expect(build(:beer)).to be_valid
    end

    it 'has a creator'
  end

  describe 'validations' do
    it 'is invalid without a name' do
      expect(build(:beer, name: nil)).not_to be_valid
    end

    it 'has a unique name, case insensitive' do
      beer1 = create(:beer, name: "Avery White Rascal")
      expect(build(:beer, name: "avery white rascal")).not_to be_valid
      expect(build(:beer, name: "AVERY WHITE RASCAL")).not_to be_valid
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
