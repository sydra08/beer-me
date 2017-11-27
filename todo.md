*To Do*
[Research]
[ ] Read docs on ActionView helper methods
[x] Review nested forms
[ ] Review nested resources
[x] Review AR query methods
[x] Review filters
[x] Review rspec (http://rspec.info/)
[ ] Review config/database.yml from other labs
[ ] figure out how to set up associations via factory and/or get seed data to be used in test env
[ ] consider using let() to set up the data for the test scenarios instead of FactoryGirl
[ ] figure out how to get seed data used in tests vs FactoryGirl
[ ] research Database Cleaner
[x] research using auto complete instead of drop down menu for brewery and category select
[x] review associations and rails section (probably worth watching video)
[ ] Look into CSS templates to use for front end

[Project]
[x] Create repo in github
[x] Generate new rails app (rails new beer-me)
[x] Write tests
    [x] Models
      [x] User
      [x] Beer
      [x] Brewery
      [x] Category
      [x] User_Beers
[x] Write migrations
  [x] User
  [x] Beer
  [x] Brewery
  [x] Category
  [x] User_Beers
[x] Create seed data using Faker (look at Flatiron Store for example)
  + beer info https://github.com/stympy/faker/blob/master/doc/beer.md
  + brewery location   https://github.com/stympy/faker/blob/master/doc/address.md
  + brewery name https://github.com/stympy/faker/blob/master/doc/company.md
  + category/beer/brewery descriptions https://github.com/stympy/faker/blob/master/doc/hipster.md
  + maybe this for Omniauth https://github.com/stympy/faker/blob/master/doc/omniauth.md
  + beer category: `Faker::Beer.style`
[ ] may need to add my own seed data instead of using faker for everything so that i can control the unique names, etc
[x] Set up models and associations
[ ] Write feature tests
  [x] without auth
    [x] User
    [x] Category
    [x] Brewery
    [x] Beer
  [ ] Add Auth to feature tests  
    [ ] User
    [ ] Category
    [ ] Brewery
    [ ] Beer
    [ ] consider using a helper for login/logout/signup actions
[x] Create root path (welcome#home)
[ ] Omniauth
[x] User can add a beer to their collection (user clicks on button and submits form to create new user_beer)
  - should this be handled via beer or user? or straight thru user_beer?
    - since this can occur via brewery or category page, should just happen there? where do the views go for this? assuming would be better as a partial since the button will appear in more than one place
[x] User can add a new beer to their collection and the database
  [x] When adding a new beer to their collection they can also add a new Brewery to the database (use fieldset)
    - need to figure out the proper way to handle this
  [x] When adding a new beer to their collection they can also add a new Category to the database (use fieldset)
    - need to figure out the proper way to handle this
[ ] May want to consider adding bootstrap early on if I want responsive design?
[ ] test the adding beer functionality
[ ] add status and notes fields to beer form...this will involve tapping into the user_beer model which complicates things bc the new beer form is part of the beer controller...
[ ] nested route for adding a new user beer (which will encapsulate the current new beer form)
[ ] filters (maybe create a partial for each filter?)
  [x] beers#index (category or brewery or both)
  [ ] breweries#index (category)
  [x] breweries#show (by category)
  [ ] categories#index (brewery)
  [x] categories#show (brewery)
[x] Logout
[ ] User authentication and authorization
[ ] User can only add beers to their own collection
[ ] User cannot edit the details for a beer that they didn't add to the database   
[ ] User cannot edit the details for a brewery that they didn't add to the database   
[ ] User cannot edit the details for a category that they didn't add to the database   
[ ] navbar
[ ] refactor beers#index (filtering)

*Helper Methods*
+ pluralize(number, phrase/word)

*rspec*
```
# the -T flag tells the Rails project generator not to
# include TestUnit, the default testing framework:
rails new rails-activerecord-models-and-rails-readme -T

# The Rails project generator created this directory for us:
cd rails-activerecord-models-and-rails-readme

# We modified the Gemfile to include
# gem 'rspec-rails', '~> 3.0'
# in the :development, :test group, then ran:

bundle install

# Finally, we created the initial RSpec config:
rails g rspec:install
```
