describe "Feature Test: User's Beer Collection", :type => :feature do
  describe "Adding Beer" do
    context "beer already exists in database" do
      # log in as user
      # nav to new beer page
      # fill_in("beer[name]", :with => "Fat Tire")
      # fill_in("beer[abv]", :with => "5.20%")
      # fill_in("beer[description]", :with => Faker::Hipster.paragraph(3))
      # fill_in("beer[brewery_attributes][name]", :with => "New Belgium Brewery")
      #   # or select existing?
      # fill_in("beer[brewery_attributes][location]", :with => "Fort Collins, CO")
      # fill_in("beer[category_attributes][name]", :with => "Amber Ale")
      # click_button('Add Beer')
      # does not create a new beer object
        # Beer.all.count stays the same
      # creates a new user_beer object
      # adds the beer to the user collection
        # user.beers.count increases by one
      # sets status to tried
      # sets status to want to try
      # it redirects you to user homepage
        # expect(current_path).to eq('/users/1')
        # expect(page).to have_content("Fat Tire")
    end
    context "adding a new beer to database" do
      # adds the beer to the database
        # Beer.all.count increases by one
      # adds the beer to the collection
        # user.beers.count increases by one
      # it redirects you to user homepage
        # expect(current_path).to eq('/users/1')
      # assign beer to existing brewery
        # expect brewery.beers.count to increase by one
      # add new brewery
        # Brewery.all.count increases by one
      # assign beer to existing category
        # expect category.beers.count to increase by one
      # add new category
        # Category.all.count increases by one
      # sets the creator id
    end
  end
  describe "Editing A Beer" do
    it "updates status to tried"
    # user changes status to tried from want to try
    it "updates user's beer notes"
    # user makes a change to the beer notes
    # it does not make changes if the user submits a blank format
    # if user deletes all content it allows it
  end

  describe "Removing A Beer" do
    it "removes beer from user's collection"
    # check that it removes the user_beer instance
    # make sure that the beer still exists in the database
  end
end
