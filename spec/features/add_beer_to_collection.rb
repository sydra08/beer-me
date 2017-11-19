describe "Feature Test: User's Beer Collection", :type => :feature do
  describe "Adding Beer" do
    context "beer already exists in database" do
      # does not create a new beer object
      # creates a new user_beer object
      # adds the beer to the user collection
      # sets status to tried
      # sets status to want to try
      # it redirects you to user homepage
    end
    context "adding a new beer to database" do
      # adds the beer to the database
      # adds the beer to the collection
      # it redirects you to user homepage
      # add new brewery
      # add new category
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
