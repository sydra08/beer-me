# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes)
  + category has many beers
- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User)
  + beer belongs to a brewery
- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients)
  + user has many beers through userbeers
- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity)
  + user beer status and notes
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
  + Beer name needs to be present and unique, the abv must be a number <= 100
  + Brewery name needs to be present and unique
  + Category name needs to be present and unique
  + User email needs to be present, unique, and have the proper format; password needs to be at least 8 characters
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
  + Beer model, #Beer.by_category_and_brewery, http://localhost:3000/beers
- [x] Include a nested form writing to an associated model using a custom attribute writer (form URL, model name e.g. /recipe/new, Item)
  + users/:id/beers/new => new brewery, beer and/or category
- [x] Include signup (how e.g. Devise)
  + created own signup, used bcrypt
- [x] Include login (how e.g. Devise)
  + sessions controller
- [x] Include logout (how e.g. Devise)
  + sessions controller
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
  + Google+
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
  + users/:id/user_beers
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients)
  + users/:id/beers/new
- [ ] Include form display of validation errors (form URL e.g. /recipes/new)

Confirm:
- [ ] The application is pretty DRY
- [ ] Limited logic in controllers
- [ ] Views use helper methods if appropriate
- [ ] Views use partials if appropriate
