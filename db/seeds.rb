# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

# original demo subscribers from subscribers controller
subscribers = [
  {
    name: "Rick Sanchez",
    email: "rickc137@citadel.com",
    status: "active"
  },
  {
    name: "Morty Smith",
    email: "morty.smith@gmail.com",
    status: "inactive"
  },
  {
    name: "Jerry Smith",
    email: "jerry.smith@aol.com",
    status: "active"
  },
  {
    name: "Beth Smith",
    email: "beth.smith@gmail.com",
    status: "active"
  },
  {
    name: "Summer Smith",
    email: "summer.smith@gmail.com",
    status: "active"
  },
  {
    name: "Bird Person",
    email: "bird.person@birdworld.com",
    status: "active"
  }
]

subscribers.each do |subscriber|
  Subscriber.create!(email: subscriber[:email], name: subscriber[:name], status: subscriber[:status])
end

27.times do |n|
  email = Faker::Internet.unique.email
  name = Faker::Name.name
  status = ['active', 'inactive'].sample
  Subscriber.create!(email: email, name: name, status: status)
end
