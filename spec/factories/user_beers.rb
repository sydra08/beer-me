FactoryGirl.define do
  factory :user_beer do
    user_id 1
    beer_id 1
    status false
    notes {Faker::Hipster.paragraph(3)}
  end
end
