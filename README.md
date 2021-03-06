# About BeerMe

BeerMe is a Rails app with a jQuery frontend that allows you to track beers that you want to try and beers that you've tried. Not only can you manage your own list of beers but you can browse other beers, breweries and categories that other users have added.

## Install & Usage Instructions

To install, clone or fork this repository, then run `bundle install` from the terminal prompt.

To create a new version of the database, populate it with seed data, and get started, run the following commands from the terminal prompt:

```ruby
rake db:drop
rake db:migrate
rake db:seed
rails s
```

In your browser, navigate to `localhost:3000`.

## Contributions

Bug reports and pull requests are welcome on GitHub at https://github.com/sydra08/beer-me. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

This project is available as open source under the terms of the [MIT License](https://github.com/sydra08/beer-me/blob/master/LICENSE).

## Credits

Shout out to [Templated.co](https://templated.co/) for the CSS template used in this app.
