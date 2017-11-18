require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'test factory' do
    it "has a valid category factory with a name and description" do
      expect(build(:category).name).not_to be_blank
      expect(build(:category).description).not_to be_blank
    end
  end

  describe 'associations' do
    it 'has many beers'
    it 'has many breweries through beers'
  end
end
