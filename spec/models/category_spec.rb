require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'test factory' do
    it 'has a name' do
      expect(create(:category).name).not_to be_blank
    end

    it 'has a description' do
      expect(create(:category).description).not_to be_blank
    end
  end

  describe 'associations' do
    it 'has many beers'
    it 'has many breweries through beers'
  end
end
