require 'faker'

# may need to use the aliasing and association mentioned in this doc (http://www.rubydoc.info/gems/factory_girl/file/GETTING_STARTED.md)

FactoryGirl.define do
  factory :user do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    email {Faker::Internet.email}
    password {Faker::Internet.password(8,16)}
  end
end

#can use FactoryGirl to generate several test users at once
