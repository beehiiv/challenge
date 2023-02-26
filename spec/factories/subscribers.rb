# frozen_string_literal: true

FactoryBot.define do
  factory :subscriber do
    name {  Faker::Name.name }
    email { Faker::Internet.email }
    status { :inactive }
  end
end
