require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    
    describe "test factory" do
      it "has a valid user factory with a first_name, last_name, email, and password"
    end

    describe "email" do
      it "is invalid without an email"
      it "has a unique email address"
      it "is invalid without proper email format (ex. user@gmail.com)"
    end

    describe "password" do
      it "is invalid without a password"
      it "is invalid if the password is less than 8 characters"
      it "encrypts the user password"
    end
  end

  describe "relationships" do
    it "has many user_beers"
    it "has many beers through user_beers"
  end

  describe "class methods" do
  end

  describe "instance methods" do
  end

end
