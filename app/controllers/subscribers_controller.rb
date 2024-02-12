# frozen_string_literal: true

class SubscribersController < ApplicationController
  include PaginationMethods
  
  PER_PAGE = 10 # Number of records per page

  # GET /api/subscribers
  def index
    page = (params[:page] || 1).to_i
    offset = (page - 1) * PER_PAGE

    subscribers = Subscriber.all
    limited_subscribers = subscribers.limit(PER_PAGE).offset(offset)

    total_records = subscribers.count

    render json: {
      subscribers: limited_subscribers,
      pagination: {
        current_page: page,
        total_records: total_records,
        total_pages: (total_records / PER_PAGE.to_f).ceil
      }
    }, formats: :json
  end

  def create
    begin

      if Subscriber.exists?(email: params[:email].downcase)
        subscriber = Subscriber.find_by(email: params[:email].downcase)
        subscriber.update(name: params[:name])
        render json: {message: "Subscriber updated successfully"}, formats: :json, status: :ok
        return
      end

      subscriber = Subscriber.new(subscriber_params)
  
      if subscriber.save
        render json: {message: "Subscriber created successfully"}, formats: :json, status: :created
      else
        render json: {errors: subscriber.errors.full_messages}, formats: :json, status: :unprocessable_entity
      end
    rescue => e
      render json: {error: "Internal Server Error"}, status: :internal_server_error
    end
  end

  def update
    begin
      subscriber = Subscriber.find_by(id: params[:id])

      if subscriber.nil?
        render json: {errors: "Subscriber not found"}, formats: :json, status: :not_found
        return
      end

      if subscriber.status.nil?
        render json: {errors: "Subscriber status is nil"}, formats: :json, status: :internal_server_error
        return
      end

      subscriber_status = subscriber.status == "active" ? "inactive" : "active"
      if subscriber.update(status: subscriber_status)
        render json: {message: "Subscriber updated successfully"}, formats: :json, status: :ok
      else
        render json: {errors: subscriber.errors.full_messages.join(", ")}, formats: :json, status: :unprocessable_entity
      end
    rescue => e
      render json: {error: "Internal Server Error"}, status: :internal_server_error
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:name, :email, :status)
  end

  def validate_email
    pass
  end
end