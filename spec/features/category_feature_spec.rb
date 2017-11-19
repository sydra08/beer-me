describe 'Feature Test: Category', :type => :feature do

  describe 'Index' do
    before(:each) do
      5.times do
        create(:category)
      end
      # navigate to page
      visit categories_path
    end

    it 'lists all categories' do
      # expect the page to have all the categories as links
      Category.all.each do |c|
        expect(page).to have_link(c.name, href: category_path(c))
      end
    end

    it 'displays the total number of beers currently in that category'
      # set a category with x number of beers
      # expect page to have category (# beers)
  end

  describe 'Beer List' do
    # sometimes these fail when the category or brewery already exists
    # need to figure out how to not use the FactoryGirl for these
    before(:each) do
      @category = create(:category)
      @brewery = create(:brewery)
      5.times do
        create(:beer, brewery: @brewery, category: @category)
      end
      visit category_path(@category)
    end

    it 'displays category name and description' do
      # expect the page to have the category name
      expect(page).to have_content(@category.name)
      expect(page).to have_content(@category.description)
    end

    it 'lists all of the beers in that category' do
      # expect the page to have the beers from that category with links to individual page
      @category.beers.each do |beer|
        expect(page).to have_link(beer.name, href: beer_path(beer))
      end
    end

    context 'logged out' do
      it 'does not display "add to list" buttons' do
        # navigate to a category page
        visit category_path(@category)
        # expect the page not to have button 'tried'
        expect(page).not_to have_selector("input[type=submit][value='Tried']")
          # expect page not to have button 'want to try'
        expect(page).not_to have_selector("input[type=submit][value='Want to Try']")
      end
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

      it 'displays beer status if available'

    end
  end
end
