# frozen_string_literal: true

class SubscribersController < ApplicationController
  include PaginationMethods

  ##
  def initialize(name: name, email: email)
    @name = name
    @email = email
  end
  
  # GET /api/subscribers
  def index
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
      },
      {
        id: 6,
        name: "Bird Person",
        email: "bird.person@birdworld.com",
        status: "active"
      }
    ]

    total_records = subscribers.count
    limited_subscribers = subscribers[offset..limit]

    render json: {subscribers: limited_subscribers, pagination: pagination(total_records)}, formats: :json
  end

  def create
    subscriber = Subscriber.create(
      name: @name, 
      email: @email, 
    )
    
    if subscriber.valid?
      render json: {message: "Subscriber created successfully"}, formats: :json, status: :created
    else
      render json: {message: "Subscriber not created"}, formats: :json
    end
  end

  def update(status: status)
    updated_subscriber = subscriber.update(status: status)

    if updated_subscriber.save?
      render json: {message: "Subscriber updated successfully"}, formats: :json, status: :ok
    else
      render json: {message: "Subscriber not updated"}, formats: :json
    end
  end
end
