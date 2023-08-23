# frozen_string_literal: true

class SubscribersController < ApplicationController
  include PaginationMethods

  def index
    subscribers = Subscriber.limit(limit).offset(offset).order(created_at: :desc)

    render json: { subscribers: subscribers, pagination: pagination(Subscriber.count) }, formats: :json
  end

  def create
    subscriber = Subscriber.new(subscriber_params)
    
    if subscriber.save
      render json: { message: "Subscriber created successfully" }, formats: :json, status: :created
    else
      render json: { message: subscriber.errors.full_messages.join(" ") }, formats: :json, status: :unprocessable_entity
    end 
  end

  def update
    subscriber = Subscriber.find(params[:id])
    updated_subscriber = subscriber.update(status: params[:status])

    if subscriber.save
      render json: { message: "Subscriber updated successfully" }, formats: :json, status: :ok
    else
      render json: { message: subscriber.errors.full_messages.join(" ") }, formats: :json, status: :unprocessable_entity
    end
  end

  private

  def subscriber_params
    params.permit(:name, :email)
  end
end
