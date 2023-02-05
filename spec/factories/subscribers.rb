FactoryBot.define do
  factory :subscriber do
    email      { Faker::Internet.email }
    name       { Faker::Name.name }
    subscribed { false }
  end
end
