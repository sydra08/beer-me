FactoryGirl.define do
  factory :beer do
    name {Faker::Beer.name}
    description {Faker::Hipster.paragraph(3)}
    brewery_id 1
    category_id 1
    abv {Faker::Beer.alcohol}
  end
end
