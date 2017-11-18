require 'rails_helper'

RSpec.describe Brewery, type: :model do
  describe 'test factory' do
    it 'has a name' do
      expect(create(:brewery).name).not_to be_blank
    end

    it 'has a description' do
      expect(create(:brewery).description).not_to be_blank
    end

    it 'has a location' do
      expect(create(:brewery).location).not_to be_blank
    end
  end

  describe 'associations' do
    it 'has many beers'
    it 'has many categories through beers'
  end
end
