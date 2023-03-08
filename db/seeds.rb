# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
subscribers = [
  {
    id: 1,
    name: "Rick Sanchez",
    email: "rickc137@citadel.com",
    status: "active"
  },
  {
    id: 2,
    name: "Morty Smith",
    email: "morty.smith@gmail.com",
    status: "inactive"
  },
  {
    id: 3,
    name: "Jerry Smith",
    email: "jerry.smith@aol.com",
    status: "active"
  },
  {
    id: 4,
    name: "Beth Smith",
    email: "beth.smith@gmail.com",
    status: "active"
  },
  {
    id: 5,
    name: "Summer Smith",
    email: "summer.smith@gmail.com",
    status: "active"
  }
]

# TODO: add a print message how many were created if any
subscribers.each do |subscriber|
  Subscriber.create(subscriber)
end