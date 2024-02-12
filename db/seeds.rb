# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
  },
  {
  	name: "Uncle Steve",
  	email: "steve@totallynotaparasite.com",
  	status: "inactive"
  },
  {
  	name: "Sleepy Gary",
  	email: "gary@totallynotaparasite.com",
  	status: "active"
  },
  {
  	name: "Pensylvester",
  	email: "Pensylvester@totallynotaparasite.com",
  	status: "inactive"
  },
  {
  	name: "Tinkles",
  	email: "Tinkles@totallynotaparasite.com",
  	status: "active"
  },
  {
  	name: "Cousin Nicky",
  	email: "nicky@totallynotaparasite.com",
  	status: "active"
  }  
]

subscribers.each do |subscriber_data|
  Subscriber.create!(
    name: subscriber_data[:name],
    email: subscriber_data[:email],
    status: subscriber_data[:status]
  )
end