*To Do*
[ ] Read docs on ActionView helper methods
[ ] Review nested forms
[ ] Review nested resources
[ ] Review filters
[x] Review rspec (http://rspec.info/)
[ ] Review config/database.yml from other labs

[x] Create repo in github
[x] Generate new rails app (rails new beer-me)
[ ] create db (rake db:create - not needed when you have a test suite)
[ ] Write tests
    + Ideally for features and models, but start with models and see how that goes
[ ] Write migrations
[ ] Create seed data
[ ] Set up models and associations
[ ] Create root path (welcome#home)
[ ] Omniauth
[ ] Pick easier routes to deal with and start there
[ ] May want to consider adding bootstrap early on if I want responsive design?
[ ] Look into CSS templates to use for front end

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
