Category.create(name: "India Pale Ale", description:  Faker::Hipster.paragraph(3))
Category.create(name: "Red Ale", description:  Faker::Hipster.paragraph(3))
Category.create(name: "Belgian Wheat Ale", description:  Faker::Hipster.paragraph(3))
Category.create(name: "Pilsner", description:  Faker::Hipster.paragraph(3))
Category.create(name: "Lager", description:  Faker::Hipster.paragraph(3))

5.times do
  Brewery.create(
    name: Faker::Company.name,
    description: Faker::Hipster.paragraph(5),
    location: "#{Faker::Address.city}, #{Faker::Address.state_abbr}"
  )
end

counter = 1
4.times do
  Beer.create(
    name: Faker::Beer.name,
    description: Faker::Hipster.paragraph(3),
    brewery: Brewery.find_by(id: counter),
    category: Category.find_by(id: counter),
    abv: Faker::Beer.alcohol.sub(/%/,"")
  )
  counter += 1
end

user = User.create(
    first_name: "Rick",
    last_name: "Sanchez",
    email: "picklerick@test.com",
    password: "password"
  )

user.beers << Beer.all

# user_beer = user.user_beers.first
# user_beer.update(status: true, notes: "I love this beer")

# need to adjust seed data so that it creates unique items
