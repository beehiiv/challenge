# frozen_string_literal: true

class SubscribersController < ApplicationController
  include PaginationMethods

  def index
    subscribers = Subscriber.order(:created_at)

    total_records = subscribers.count
    limited_subscribers = subscribers.drop(offset).first(limit)

    render json: { subscribers: limited_subscribers, pagination: pagination(total_records) }, formats: :json
  end

  def create
    subscriber = Subscriber.create(subscriber_params)

    if subscriber.valid?
      render json: { message: "Subscriber created successfully" }, formats: :json, status: :created
    else
      render json: { message: subscriber.errors.messages }, formats: :json, status: :not_acceptable
    end
  end

  def update
    subscriber = Subscriber.find(params[:id])

    subscriber.update(subscriber_params)

    if subscriber.valid?
      render json: { message: "Subscriber updated successfully" }, formats: :json, status: :ok
    else
      render json: { message: subscriber.errors.messages }, formats: :json, status: :not_acceptable
    end
  end

  private

  def subscriber_params
    params.permit(:name, :email, :status)
  end
end
