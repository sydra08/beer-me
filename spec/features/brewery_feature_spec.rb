xdescribe 'Feature Test: Brewery', :type => :feature do

  describe 'Index Page' do
    before(:each) do
      5.times do
        create(:brewery)
      end
      # navigate to page
      visit breweries_path
    end

    it 'lists all breweries' do
      # expect the page to have all the breweries as links
      # expect page to include the brewery location
      Brewery.all.each do |b|
        expect(page).to have_link(b.name, href: brewery_path(b))
      end
    end
  end

  describe 'Show Page' do
    # sometimes these fail when the category or brewery already exists
    # need to figure out how to not use the FactoryGirl for these
    before(:each) do
      @category = create(:category)
      @brewery = create(:brewery)
      5.times do
        create(:beer, brewery: @brewery, category: @category)
      end
      visit brewery_path(@brewery)
    end

    it 'displays brewery information' do
      # expect the page to have the brewery name
      expect(page).to have_content(@brewery.name)
      # expect the page to have the description
      expect(page).to have_content(@brewery.description)
      # expect the page to have the location
      expect(page).to have_content(@brewery.location)
    end

    it 'lists all of the beers from that brewery' do
      # expect the page to have the beers from that brewery
      @brewery.beers.each do |beer|
        expect(page).to have_link(beer.name, href: beer_path(beer))
      end
    end

    it 'allows you to filter the beer list by category'
    it 'allows you to sort the beer list alphabetically by name'

    context 'logged out' do
      it 'does not display "add to list" buttons'
        # navigate to a category page
        # expect the page not to have button 'tried'
        # expect page not to have button 'want to try'
    end

    context 'logged in' do
      # before log user in
      it 'displays "add to list" buttons'
        # # navigate to a category page
        # visit category_path(@category)
        # # expect the page to have button 'tried'
        # expect(page).to have_selector("input[type=submit][value='Tried']")
        # # expect page to have button 'want to try'
        # expect(page).to have_selector("input[type=submit][value='Want to Try']")

      it 'displays beer status for user if available'

    end
  end
end
