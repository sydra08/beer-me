*December 11 Goals*
[ ] think through the refactoring of the beers#index
  + the userbeer vs beer filtering is cumbersome and probably not the best way to do this...but you can't really combine it because userbeer vs beer objects are different
  + beers#index is the only index page that has filtering
  + can't remove filtering on this view of the page bc then it's inconsistent with the rest of the site
  + what if the user landing page is slightly different and you have to choose by status first?
  + maybe the userbeers#index page should exist? then it would handle all of the userbeers vs beers in general - that could help cut down on the amount of code in the beers controller...but is that even a thing you do?
[ ] figure out how to get notes and status added to beers when user adds new one to collection
  + can i create a stand in userbeer instance that can be used to generate the fields_for area of the add_beer form?
  + then when you add a new beer to your collection it adds the notes and status to the created userbeer instance
  + can there be a join table controller? or is that bad practice? https://softwareengineering.stackexchange.com/questions/245392/do-rails-join-models-get-controllers
[ ] user can update notes and status of beer in collection
[ ] user can filter by status of beer


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
[ ] rewatch the ToDo Omniauth video before assessment

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
[x] Omniauth
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
[x] nested route for adding a new user beer (which will encapsulate the current new beer form)
[x] filters (maybe create a partial for each filter?)
  [x] beers#index (category or brewery or both)
  -[ ] breweries#index (category)-
  [x] breweries#show (by category)
  -[ ] categories#index (brewery)-
  [x] categories#show (brewery)
[x] Logout
[ ] User authentication and authorization
[ ] User can only add beers to their own collection
[ ] User cannot edit the details for a beer that they didn't add to the database   
[ ] User cannot edit the details for a brewery that they didn't add to the database   
[ ] User cannot edit the details for a category that they didn't add to the database   
-[ ] clear filter button (may not be entirely necessary)-
[ ] navbar
[x] refactor beers#index (filtering)
  [x] need to change page because it will also be used as the landing page for users when they log in
[x] need to figure out how to add status and notes when you add a beer
*[ ] what happens if a user tries to add a beer that they already have in their collection?*
  + there should probably be a safe guard against that. like if a user tries to add a beer to their list that they already have, should be a validation error. so maybe need something that says you need to have unique beer_ids within a users user_beers
[ ] figure out how the beers#show and user_beers#show can be combined?
[x] allow user to add notes for user_beer
[ ] allow edit notes for user_beer
[x] why are the nested routes coming up as .id?
[ ] when a user adds a beer the default status is want to try, should probably reflect that in the UI
[x] allow users to change a beer's status to Tried from userbeers#show
[ ] add filter on userbeer#index so that a user can filter by status
[ ] consider incorporating the ratings feature so that there's a better scope method example
*[ ] make list of questions for one-on-one session*
[ ] add generic/standard beer types to seed data

UX/UI
[ ] adding beer > when you type there shouldn't be an arrow in the box anymore, only when you're first seeing the fields_for
[ ] add a styling for fields_with_errors
[ ] make error message appearance consistent
[ ] center fields on sign up and sign in pages
[ ] if user doesn't have beer there shouldn't be filters - figure out a better way to handle this. if you filter and there are no results you don't see filters...
[x] fix styling of home page
[x] add pictures to home_page
[ ] figure out the proper navbar set up for home vs not
[ ] fix styling for forms
  [x] update sign up
  [x] update sign in
  - [ ] update add beer so that there are placeholders
[ ] styling for the flash messages  

BUGS
[/] error messaging on sign up page
  - added more obvious error messaging, may want to add a styling for fields_with_errors
[x] adding beer > maybe put the brewery at the top so it's easier to understand?
[ ] validation should be on unique brewery vs unique beer name (more realistic)
  - can you conditionalize a validation? do i have to write a custom one here?
    - if name exists + brewery matches => don't create record
    - else if name exists + brewery doesn't match => create new record
    - need to make sure to only show unique values in selection list, otherwise it would look bad with dupes
[x] restrict abv to be under 100.00
[ ] user's notes aren't showing up - just showing other notes
[ ] still issues with adding a new beer, clicking on it and it taking you to previously created beer
[ ] hanging on filters   

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
