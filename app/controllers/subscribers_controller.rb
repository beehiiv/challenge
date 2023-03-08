# frozen_string_literal: true

class SubscribersController < ApplicationController
  include PaginationMethods

  ##
  # GET /api/subscribers
  def index
    subscribers = Subscriber.all

    total_records = subscribers.count
    limited_subscribers = subscribers[offset..limit]

    render json: {subscribers: limited_subscribers, pagination: pagination(total_records)}, formats: :json
  end

  def create
    subscriber = Subscriber.create(subscriber_params)
    subscriber.status = 'active'
    success = subscriber.save
    if success
      render json: {message: "Subscriber created successfully"}, formats: :json, status: :created
    else
      render json: {message: "Failed to create subscriber", error: subscriber.errors}, formats: :json, status: :internal_server_error
    end
  end

  def update
    subscriber = Subscriber.find(params[:id])
    success = subscriber&.update(subscriber_params)
    if success
      render json: {message: "Subscriber updated successfully"}, formats: :json, status: :ok
    else
      render json: {message: "Failed to update subscriber", error: subscriber.errors}, formats: :json, status: :internal_server_error
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:id, :name, :email, :status)
  end
end
