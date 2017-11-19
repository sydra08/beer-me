5.times do
  Category.create(
    name: Faker::Beer.style,
    description: Faker::Hipster.paragraph(3)
  )

  Brewery.create(
    name: Faker::Company.name,
    description: Faker::Hipster.paragraph(5),
    location: "#{Faker::Address.city}, #{Faker::Address.state_abbr}"
  )
end

counter = 1
5.times do
  Beer.create(
    name: Faker::Beer.name,
    description: Faker::Hipster.paragraph(3),
    brewery_id: counter,
    category_id: counter,
    abv: Faker::Beer.alcohol
  )
  counter += 1
end

# need to adjust seed data so that it creates unique items
