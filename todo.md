*jQuery project*
[x] add AMS to Gemfile
[ ] clean up /app/assets/javascripts folder
[x] add JS and jQuery to app
[x] set up manifest.js file
[X] start with beers list
[X] determine whether or not a manifest file is needed for the css
  [ ] https://stackoverflow.com/questions/11052398/rails-using-font-awesome
  [ ] https://fontawesome.com/v4.7.0/get-started/
  [ ] http://edgeguides.rubyonrails.org/asset_pipeline.html
[X] figure out how to make sure that the manifests, etc are set up properly
[x] probably want a different JS file for each controller?
[x] figure out why there are so many errors when the page is loaded - removed extra scripts from the bottom of the page
[ ] more research on ActiveModel Serializers and how they work with brewery-beer relationship
[x] why does the breweries#index show the default beers#index layout? - is it because i added the serializer?
[x] need to figure out why deleting the breweries.coffee caused everything to break. should everything be in one js file? seems like too much logic in one place?
+ figured out how to revert back to old commit [https://stackoverflow.com/questions/4114095/how-to-revert-git-repository-to-a-previous-commit]
[x] need to figure out how to only load the breweries list on the breweries#index page and not the breweries#show page
[x] figure out why some functions are being called multiple times on page load when it's not necessary
[x] stop some functions from running on specific pages
[ ] update beer table on breweries#show
[x] why are the category options appearing on categories#show
[ ] add paperclip gem to allow for beer picture attachments
[x] fix js load so that getBeers() isn't called each time a different js file is loaded - now it only gets called once
[x] consider changing serializers so that you get less data for some things
[x] fix bug - when a brewery or category has no beers it doesn't return data...think I need to work on splitting up the Serializers and having different ones used for associated data (i.e. index pages) vs show pages
  + think it has something to do with Beer being the first thing that gets read in. so when there are no beers for something then you don't get any of the nested data. Maybe look into separating the nodes like {http://railscasts.com/episodes/409-active-model-serializers?view=asciicast} suggests?
? [ ] add statuses to the json calls
? [ ] update GET requests to use ".json" at the end of each
[ ] figure out why brewery and category data aren't showing up in the json for user_beers/:id - think that i need to add some custom methods to get this to show up - or use include in the serializer?
  [ ] maybe make a separate call to retrieve the brewery information based on the list of beers? but if i do this then when you filter it won't work since the JSON doesn't return the brewery and category data
  [ ] is there a way to make a call to the /beers endpoint for this instead with a constraint for user_id?
[ ] look into scope methods within serializer for filters? {https://github.com/rails-api/active_model_serializers/blob/v0.10.6/docs/general/serializers.md}
[ ] could use scope for user beers?
[ ] conditional for user_beers seems to make the index page load slower
[ ] can i make the notes field add new or edit?
   [ ] get it working through rails
   [ ] get it working via jQuery/AJAX  
[ ] add fail() to API calls

[/] render index page w jQuery and AMS:
  [x] **/beers** use Rails API to get data to display
    [x] create serializer for beers
    [x] confirm that JSON renders properly
    [x] update page to call a JS function that then makes the API call
  [x] **/beers** when you filter beers based on category it renders the index update without a page refresh
  [/] **/beers** when you filter beers based on brewery it renders the index update without a page refresh
    [x] figure out how to deal with the apply filter button - removed it for now
    [ ] should there be a reset filter button?
    [ ] have the filters be disabled until the document is ready and they can be used?
    [x] consider making the filters apply when you select something from them?   
  [x] **/users/:id/user_beers** when you filter beers based on category it renders the index update without a page refresh
  [x] **/users/:id/user_beers** when you filter beers based on brewery it renders the index update without a page refresh
  [x] **/breweries/:id** when you filter beers based on category it renders the index update without a page refresh
[/] render show page w jQuery and AMS:
  [/] **/breweries/:id** PREV/NEXT buttons on the page to view the other breweries (need to make sure this works within the filter concept...)
    [ ] disable the next button when it's the last one in the list
    [ ] disable the prev button when it's the first record
    [x] next button
    [x] previous button
    [ ] fix the button styling so that the arrow and the text are both clickable
    [x] need to fix this so that when you call the filter it pulls the data-id attribute for the url
  [/] **/categories/:id** PREV/NEXT buttons on the page to view the other categories (need to make sure this works within the filter concept...)
    [ ] disable the next button when it's the last one in the list
    [ ] disable the prev button when it's the first record
    [x] next button
    [x] previous button
    [x] figure out why you can't nav to /categories/5 (lager) from #4 or #6 - the data comes back as empty but when you go to the page normally it's fine
      - i think this fails when there are no beers to return YUPPPPP
    [ ] fix the button styling so that the arrow and the text are both clickable
    [x] need to fix this so that when you call the filter it pulls the data-id attribute for the url
  [/] **/beers/:id** PREV/NEXT buttons on the page to view the other beers...but maybe only the beers from that brewery? or something...
    [ ] disable the next button when it's the last one in the list
    [ ] disable the prev button when it's the first record
    [x] next button
    [x] previous button
    [ ] fix the button styling so that the arrow and the text are both clickable
    [x] make it so that the labels still appear for ABV and Description
  [ ] **/users/:id/user_beers/:id** PREV/NEXT buttons on the page to view the other user beers
    [ ] disable the next button when it's the last one in the list
    [ ] disable the prev button when it's the first record
    [x] next button
    [x] previous button
    [x] BUG: you can look through all of the beer records even if the userbeer doesn't exist because of the call to getBeer
    [ ] figure out how to get the available user beer records to be constrained to the current user
    [ ] fix the button styling so that the arrow and the text are both clickable
[/] has-many relationship
  [x] brewery has_many beers - see this on **/breweries/:id**
  [x] category has_many beers - see this on **/categories/:id**
  [x] user has_many beers - see this on **/users/:id/user_beers**
[ ] use Rails API and a form to CREATE a resource and render it without page refresh   
  [ ] add a new beer to your list while on **/beers/:id**
    [ ] when you add the new resource, it sends all the data to the beers controller and then it renders the **/users/:id/user_beers/:id** page with the correct fields
      [ ] maybe make the beers#show page look more like the userbeers#show page so that it's not as weird when it renders the new info?
  [ ] add a new beer to your list while you're on the **/beers** page?
  [/] add a new beer to **/beers** while you're on the page
    [x] only allow users to add existing breweries first? - unnecessary the class methods in the model take care of this just fine
    [ ] might be able to get this to work without changing too much in the form
    [ ] figure out how to reset the form after you are done submitting it
    [ ] figure out how to update the brewery and category options
    [ ] figure out how to keep both the new beers and new user beer routes - maybe need to rethink the userbeer process? maybe just have them be able to add beers to their list but if they want to add a new beer then they have to go through the beers#index page?
  [ ] add a new beer to a brewery while on the brewery#show page  
    [ ] build in pure rails first?
    [ ] add a form to the breweries#show page
    [ ] still need to allow user to add to a particular category or create a new one
    [ ] will probably need to make sure that the filters get reset after each time they are used?   
  [x] add new brewery to **/breweries** without full page refresh
    [x] make sure the form is empty after submit
    [x] figure out how to re-enable the button for the form
    [ ] [for when i have the add brewery button back] figure out why I only get the json view after submitting a new brewery after I added in the form show/hide functionality
  <!-- [ ] **/users/:id/user_beers/:id** add notes to beer
    [ ] hijack Add Note submission
      + the form fields on this page are both id="edit_user_beer_2" - does this have to do with form_for and can it overridden?
    [ ] send POST request to /user_beers/:id
    [ ] need to make sure to empty the notes field
  [ ] **/users/:id/user_beers/:id** update status of beer (this isn't really as interesting bc you can see the visual status change before you update it anyways. would be minor to have the button not be disabled for a bit, but a good add)
  [ ] can I incorporate something in here that helps when you're adding a new beer to collection? -->
[ ] translate JSON responses to JS Model Objects with at least one method on the prototype - going to leave this for now until I work through the rest

---
Blog Post idea
+ fixing the error where when there were no beers associated with a brewery or a category that the data returned was empty. part of it was how the Serializers were organized - the brewery and category models(?) were always linked to the beer data bc that file was being read in first (i think). wound up creating separate serializers: one for displaying the full data needed for a #Show page and one for including the bare minimum needed to figure out the associations. to use the specific serializer, the controllers had to be updated to return @brewery or @category instead of @beers. however doing this made it so that ONLY the category/brewery [removed filter logic from those 2 controllers and created getBrewery() and getCategory() functions to retrieve the data] data appeared on the page and the associated beer list didn't. so in order to preserve the filter functionality and get the assoc beer list to load, i updated getBeers() to always make requests to /beers. since the data didn't have to come solely from the associated controller, i was able to make calls to 2 separate endpoints in order for the page to load.



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
[x] Review nested resources
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
[x] Look into CSS templates to use for front end
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
[x] navbar
[x] fix beers/new to be nested under users
[x] refactor beers#index (filtering)
  [x] need to change page because it will also be used as the landing page for users when they log in
[x] need to figure out how to add status and notes when you add a beer
[ ] figure out how the beers#show and user_beers#show can be combined?
[x] allow user to add notes for user_beer
[x] why are the nested routes coming up as .id?
[x] when a user adds a beer the default status is want to try, should probably reflect that in the UI
[x] allow users to change a beer's status to Tried from userbeers#show
[ ] consider incorporating the ratings feature so that there's a better scope method example (phase 2)
[x] make list of questions for one-on-one session
[x] add generic/standard beer types to seed data
[ ] add in more conditionals for when a user visits a beers#show page so that it's not different from when they view a beer via the userbeers#index page
[ ] add filter on userbeer#index so that a user can filter by status
[ ] should i change the status to not be boolean?
[ ] change abv to be a float in the DB
*[x] what happens if a user tries to add a beer that they already have in their collection?*
  + there should probably be a safe guard against that. like if a user tries to add a beer to their list that they already have, should be a validation error. so maybe need something that says you need to have unique beer_ids within a users user_beers
  + bc it's a form_for it knows to update the record so need to update that portion of the beer controller
[x] make it so that if a user selects a brewery or beer that already exists it doesn't update the object (may need to add in the owner_id thing)
*[ ] validation should be on unique brewery vs unique beer name (more realistic)*
  - can you conditionalize a validation? do i have to write a custom one here?
    - if name exists + brewery matches => don't create record
    - else if name exists + brewery doesn't match => create new record
    - need to make sure to only show unique values in selection list, otherwise it would look bad with dupes
  - interim solution...add a check to see if the beer you're trying to add matches via brewery too? if not, then create the beer. otherwise just go with what was already created. would probably require taking out the validation around beer name uniqueness.
[ ] edit notes
[x] delete beers
[x] change beer status back from Tried
[x] create partial for beer tables?

BUGS
[x] error messaging on sign up page
  - added more obvious error messaging, may want to *add a styling for fields_with_errors*
[x] adding beer > maybe put the brewery at the top so it's easier to understand?
[x] restrict abv to be under 100.00
[x] user's notes aren't showing up - just showing other notes
[x] still issues with adding a new beer, clicking on it and it taking you to previously created beer for the brewery?
  ie. clicked on "Sunshine Wheat" and it took me to "Stone IPA" which is the other New Belgium beer
[x] hanging on filters   
[x] issues with using the "Tried" button for a beer
[x] fix filters on userbeer#index
[x] radio buttons not functional

UX/UI
[x] make index pages look consistent
[ ] if you don't have any beers you should have a better CTA on home page
-[ ] adding beer > when you type there shouldn't be an arrow in the box anymore, only when you're first seeing the fields_for-
*[ ] add a styling for fields_with_errors*
[x] make error message appearance consistent
[x] center fields on sign up and sign in pages
-[ ] if user doesn't have beer there shouldn't be filters - figure out a better way to handle this. if you filter and there are no results you don't see filters...-
[x] fix styling of home page
[x] add pictures to home_page
[x] figure out the proper navbar set up for home vs not
[x] fix styling for forms
  [x] update sign up
  [x] update sign in
  <!-- - [x] update add beer so that there are placeholders -->
[x] styling for the flash messages  
[x] fix error messaging on Sign In page so that it's consistent with the rest of the site
[x] have filters be side by side
[ ] have abv be in small caps {font-variant: small-caps;}
[x] change the button on the UserBeers#Show page to be inline

REFACTORING
[ ] use yield in partials in order to DRY up code http://guides.rubyonrails.org/layouts_and_rendering.html#using-partials

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
