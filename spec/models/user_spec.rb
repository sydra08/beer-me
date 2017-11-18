require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @brewery = create(:brewery)
    @category = create(:category)
    @beer = create(:beer, brewery: @brewery, category: @category)
    @user = create(:user)
    @user_beer = create(:user_beer, user: @user, beer: @beer, status: true)
  end

  describe "validations" do
    describe "test factory" do
      it "has a valid user factory with a first_name, last_name, email, and password" do
        expect(build(:user).first_name).not_to be_blank
        expect(build(:user).last_name).not_to be_blank
        expect(build(:user)).to be_valid
      end
    end

    describe "email" do
      it "is invalid without an email" do
        expect(build(:user, email: nil)).not_to be_valid
      end

      it "has a unique email address" do
        create(:user, email: "test@example.com")
        user = build(:user, email: "test@example.com")

        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include("Email has already been taken")

      end

      it "is invalid without proper email format (ex. user@gmail.com)" do
        expect(build(:user, email: "test.com")).not_to be_valid
      end

    end

    describe "password" do
      it "is invalid without a password" do
        expect(build(:user, password: nil)).not_to be_valid
      end

      it "is invalid if the password is less than 8 characters" do
        expect(build(:user, password: "abc")).not_to be_valid
        expect(build(:user, password: "abcdefgh")).to be_valid
      end

      it "encrypts the user password" do
        user = create(:user)
        expect(user.password_digest).not_to eq(user.password)
      end

    end
  end

  describe "associations" do
    before do
      @brewery = create(:brewery)
      @category = create(:category)
      @beer = create(:beer, brewery: @brewery, category: @category)
      @user = create(:user)
      @user_beer = create(:user_beer, user: @user, beer: @beer, status: true)
    end

    it "has many user_beers" do
      expect(@user.user_beers).to include(@user_beer)
    end

    it "has many beers through user_beers" do
      expect(@user.beers).to include(@beer)
    end
  end

end
