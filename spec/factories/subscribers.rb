# spec/factories/subscribers.rb

FactoryBot.define do
  factory :subscriber do
    name { Faker::Name.name }
    status { 'active' }
    email { Faker::Internet.email }

    before(:validation) do |subscriber|
      subscriber.send(:process_email)
      subscriber.send(:process_name)
    end
  end
end
