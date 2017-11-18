FactoryGirl.define do
  factory :category do
    name Faker::Beer.style
    description Faker::Hipster.paragraph(3)
  end
end
