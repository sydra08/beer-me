**BeerMe**

*Models*
User
  + User has_many :beers, through: :user_beers
  + User has_many :user_beers
  + think I will have to alias this as "Creator" or "Owner" in order to use it to determine who is allowed to modify something
  + Properties:
    + Name (string)
    + Email (string)
    + Password_Digest (string) #going to use bcrypt for this and not devise
    + Admin, boolean (phase 2)
  + User can log in with Google (omni auth google)
  + Maybe Facebook too (phase 2?)
  + Validations
    + email (unique and present)
    + password (at least 8 characters)

Beer
  + Beer has_many :users, through: :user_beers
  + Beer has_many :user_beers
  + Beer belongs_to :category
  + Beer has_one :owner, class_name: “User” ??
  + Properties
    + Name (string)
    + Brewery_id (integer)
    + Category_id (integer)
    + Description (text)
    + ABV (float? decimal? string?)
    + creator_id (this is set when a user creates a new beer, default: nil ?) (integer)
    + image (phase 2)
      + could use Faker placeholder images?
  + Validations
    + name (unique and present)
    + brewery (present)


Brewery
  + Brewery has_many :beers
  + Brewery has_one :owner, class_name: “User” ??
  + Or just set creator_id = user.id ??
  + Properties
    + Name
    + Location (city, state)
    + Description
    + creator_id

Category
  + Category has_many :beers
  + Category has_many :breweries, through :beers
  + Properties
    + Name
    + Description

User_Beers
  + User_beers belongs_to :user
  + User_beers belongs_to :beer
  + Properties
    + User_id
    + Beer_id
    + Status (boolean, default false = want to try)
    + Notes (Do the notes and status fields belong in here since they they describe the beer in relation to the user?)
    + Rating for a beer? (phase 2)
      + If I add ratings then you can see the highest rated beers for a brewery, a category, a user?


*Features*
User
  + Can sign up */users/signup*
  + Can log in */users/login*
  + Can log out */users/logout*
  + Can view their fridge */users/:id/beers*
    + Filter list by Status
    + Filter list by Category
      + Display in 2 columns with Tried and Want To Try
    + Filter list by Brewery
      + Display in 2 columns with Tried and Want To Try
  + Can add a new beer to their fridge *GET /users/:id/beers/new | POST /beers*
    + Nested form and resource
    + Select from db (filtered to only show ones they haven't tried yet)
      + Drop down menu?
    + Or add new beer to db (only if it doesn’t exist already)
      + Use case insensitive validation here
      + User can set a status (want to try or tried)
      + User can add notes about beer (only visible to creator)
  + Can edit a beer in their fridge *GET /users/:id/beers/edit | POST /beers/update*
    + not sure if this is the RESTful and DRY way to do this
    + user can update notes
    + user can change/update status
  + Can remove a beer from their fridge */users/:id/beers/delete*
    + not sure if this is the RESTful and DRY way to do this
  + If a user’s fridge is empty, they can add beers in bulk (maybe phase 2)
    + Need to figure out proper UX for this

Beer
  + Can be created by a logged in user *GET /beers/new | POST /beers*
    + you can create a new brewery at the same time that you create a new beer
    + Owner_id is set
  + Can view a beer */beers/:id*
    + See name, abv, description, brewery (link), category (link)
    + If user is logged in and the beer is not already in their fridge they have the option to add it
      + Maybe two buttons “Tried” and “Want to Try”
    + If user is logged in and beer is already in the user’s fridge they can see the status and notes
      + User has option to edit status and notes
      + If current_user is the owner of that record, they have the option to edit the record
        + Abv, description, brewery
    + If current_user is an admin, they can delete the record (phase 2)
  + Can view list of beers in database *GET /beers*
    + Filter list by Category
    + Filter list by Brewery
    + Sort list by ABV?
    + Sort list by Name
    + If user is logged in, they will see (tried/want to try) next to each beer?

Brewery
  + Can view list of breweries in database *GET /breweries*
    + Filter list by State
    + Sort list by Name (A-Z and Z-A)
    + List has Name (link) | City, State
  + Can visit a brewery page *GET /breweries/:id*
    + See name, state, city
    + If a brewery has beers, then you can see a list of beers (default sort a-z)
    + Can filter list by Category
    + If user is logged in they can see the status for each beer from that brewery
    + Should a user be able to add beers to fridge from this view? (phase 2)
    + users can only add a brewery via adding a new beer?

Category
  + Can view a list of categories *GET /categories*
    + Category (# beers) - link to category_path(category)
  + Can view a category page *GET /categories/:id*
    + See name and description
    + If a category has beers, then you can see a list of beers (default sort a-z)
    + If user is logged in they can see the status for each beer from that category
    + Should a user be able to add beers to fridge from this view? (phase 2)
      + Similar to “adding to a cart” you don’t get taken away from view
    + users can only add a category via adding a new beer? or will this just be an admin right? (phase 2)
