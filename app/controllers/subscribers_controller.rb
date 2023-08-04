# frozen_string_literal: true

class SubscribersController < ApplicationController
  include PaginationMethods

  ##
  # GET /api/subscribers
  def index
    subscribers = Subscriber.all.order(created_at: :asc)
    total_records = subscribers.count

    limited_subscribers = subscribers.offset(offset).limit(limit)

    render json: {subscribers: limited_subscribers, pagination: pagination(total_records)}, formats: :json
  end

  def create
    subscriber = Subscriber.new(subscriber_params)

    if subscriber.save
      render json: {message: "Subscriber created successfully"}, formats: :json, status: :created
    else
      render json: {message: subscriber.errors.full_messages.join(", ")}, formats: :json, status: :unprocessable_entity
    end
  end

  def update
    subscriber = Subscriber.find_by(id: params[:id])
    
    if subscriber.nil?
      render json: {message: "Subscriber not found"}, formats: :json, status: :not_found
      return
    end

    subscriber_status = subscriber.status == "active" ? "inactive" : "active"

    if subscriber.update(status: subscriber_status)
      render json: {message: "Subscriber updated successfully"}, formats: :json, status: :ok
    else
      render json: {message: subscriber.errors.full_messages.join(", ")}, formats: :json, status: :unprocessable_entity
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:name, :email, :status)
  end
end
