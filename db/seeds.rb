10.times do
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
