*To Do*
[Research]
[ ] Read docs on ActionView helper methods
[ ] Review nested forms
[ ] Review nested resources
[ ] Review filters
[x] Review rspec (http://rspec.info/)
[ ] Review config/database.yml from other labs
[ ] figure out how to set up associations via factory and/or get seed data to be used in test env
[ ] consider using let() to set up the data for the test scenarios instead of FactoryGirl
[ ] figure out how to get seed data used in tests vs FactoryGirl
[ ] research Database Cleaner
[ ] Look into CSS templates to use for front end

[Project]
[x] Create repo in github
[x] Generate new rails app (rails new beer-me)
[ ] Write tests
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
  [ ] without auth
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
[ ] User can add a beer to their collection
[ ] User can add a new beer to their collection and the database
  [ ] When adding a new beer to their collection they can also add a new Brewery to the database
  [ ] When adding a new beer to their collection they can also add a new Category to the database
[ ] May want to consider adding bootstrap early on if I want responsive design?
[ ] Logout
[ ] User authentication and authorization
[ ] User can only add beers to their own collection
[ ] User cannot edit the details for a beer that they didn't add to the database   
[ ] User cannot edit the details for a brewery that they didn't add to the database   
[ ] User cannot edit the details for a category that they didn't add to the database   

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
