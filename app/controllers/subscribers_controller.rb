# frozen_string_literal: true

class SubscribersController < ApplicationController
  include PaginationMethods

  ##
  # POST /api/subscribers
  def create
    subscriber = Subscriber.create(create_params)

    if subscriber.persisted?
      redirect_to subscribers_path
      return
    end

    errors = subscriber.errors.full_messages.join(", ")

    render(
      formats: :json,
      json: {message: "Subscriber could not be created: #{errors}"},
      status: :unprocessable_entity
    )
  end

  ##
  # GET /api/subscribers
  def index
    render json: {subscribers: subscribers, pagination: pagination(total_records)}, formats: :json
  end

  ##
  # PATCH /api/subscribers/:id
  def update
    subscriber = Subscriber.find_by(id: params[:id])

    if subscriber.nil?
      render json: {message: "Subscriber not found"}, formats: :json, status: :not_found
      return
    end

    if subscriber.update(update_params)
      render json: {message: "Subscriber updated successfully"}, formats: :json, status: :ok
      return
    end

    errors = subscriber.errors.full_messages.join(", ")

    render(
      formats: :json,
      json: {message: "Subscriber could not be updated: #{errors}"},
      status: :unprocessable_entity
    )
  end

  private

  def create_params
    params.require(:subscriber).permit(:email, :name)
  end

  def subscribers
    @subscribers ||=
      Subscriber
        .limit(limit)
        .offset(offset)
        .order(name: :asc)
  end

  def total_records
    subscribers.count
  end

  def update_params
    params.require(:subscriber).permit(:status)
  end
end
