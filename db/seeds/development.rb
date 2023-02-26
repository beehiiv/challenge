# frozen_string_literal: true

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

subscribers.each { |subscriber| Subscriber.create!(subscriber) }
