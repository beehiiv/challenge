# frozen_string_literal: true

class SubscribersController < ApplicationController
  include PaginationMethods

  def index
    subscribers = Subscriber.all

    total_records = subscribers.count
    limited_subscribers = subscribers.drop(offset).first(limit)

    render json: { subscribers: limited_subscribers, pagination: pagination(total_records) }, formats: :json
  end

  def create
    render json: { message: "Subscriber created successfully" }, formats: :json, status: :created
  end

  def update
    render json: { message: "Subscriber updated successfully" }, formats: :json, status: :ok
  end
end
