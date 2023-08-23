# frozen_string_literal: true

class SubscribersController < ApplicationController
  include PaginationMethods

  def index
    subscribers = Subscriber.all.order(created_at: :desc)
    total_records = Subscriber.count
    limited_subscribers = subscribers[offset..limit]

    render json: {subscribers: limited_subscribers, pagination: pagination(total_records)}, formats: :json
  end

  def create
    subscriber = Subscriber.create(
      name: params[:name], 
      email: params[:email],
    )
    
    if subscriber.valid?
      render json: {message: "Subscriber created successfully"}, formats: :json, status: :created
    else
      render json: { errors: subscriber.errors.full_messages }, :status => 422
    end
  end

  def update
    subscriber = Subscriber.find(params[:id])
    updated_subscriber = subscriber.update(status: params[:status])

    if subscriber.valid?
      render json: {message: "Subscriber updated successfully"}, formats: :json, status: :ok
    else
      render json: {message: "Subscriber not updated"}, formats: :json
    end
  end
end
