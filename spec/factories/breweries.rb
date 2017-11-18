FactoryGirl.define do
  factory :brewery do
    name Faker::Company.name
    description Faker::Hipster.paragraph(5)
    location "#{Faker::Address.city}, #{Faker::Address.state_abbr}"
  end
end
