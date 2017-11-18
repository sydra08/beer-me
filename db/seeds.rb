10.times do
  Category.create(
    name: Faker::Beer.style,
    description: Faker::Hipster.paragraph(3)
  )
end
