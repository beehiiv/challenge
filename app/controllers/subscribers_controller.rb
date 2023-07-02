# frozen_string_literal: true

class SubscribersController < ApplicationController
  include PaginationMethods

  rescue_from StandardError, :with => :handle_uncaught_errors

  ##
  # GET /api/subscribers
  def index
    subscribers = Subscriber.all

    total_records = subscribers.size # to avoid an additional query if possible
    limited_subscribers = subscribers.limit(limit).offset(offset)

    render json: {subscribers: limited_subscribers, pagination: pagination(total_records)}, formats: :json
  end

  def create
    subscriber = Subscriber.new({
      name: params["name"],
      email: params["email"]
    })

    if subscriber.valid?
      subscriber.save
      render json: subscriber, formats: :json, status: :created
    else
      render json: {
        message: "Subscriber could not be created",
        errors: subscriber.errors.messages
      }, formats: :json, status: :bad_request
    end
  end

  def update
    subscriber = Subscriber.find_by(id: params["id"])
    
    if subscriber.nil?
      render json: {message: "Subscriber could not be found"}, formats: :json, status: :not_found
    else
      subscriber.status = params["status"]
      if subscriber.valid?
          subscriber.save
          render json: subscriber, formats: :json, status: :ok
      else
        render json: {
          message: "Subscriber could not be updated",
          errors: subscriber.errors.messages
        }, formats: :json, status: :bad_request
      end
    end
  end

  private
  
  def handle_uncaught_errors(error)
    # todo: add error logging here
    render json: {
      message: "Subscriber could not be updated",
      errors: {
        "unknown": error || "Something went wrong",
      }
    }, formats: :json, status: :bad_request
  end
end
