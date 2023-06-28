# frozen_string_literal: true

class SubscribersController < ApplicationController
  include PaginationMethods

  ##
  # GET /api/subscribers
  def index
    subscribers = Subscriber.all.by_recently_created

    total_records = subscribers.count
    limited_subscribers = subscribers.limit(limit).offset(offset)

    render json: {subscribers: limited_subscribers, pagination: pagination(total_records)}, formats: :json
  end

  def create
    subscriber = Subscriber.new(email: params[:email], name: params[:name], status: 'active')
    if subscriber.save
      render json: {message: "Subscriber created successfully"}, formats: :json, status: :created
    else
      puts "Invalid entry"
    end
  end

  def update
    subscriber = Subscriber.find(params[:id])

    updated_status = subscriber.status == 'active' ? 'inactive' : 'active'

    if subscriber.update({status: updated_status})
      render json: {message: "Subscriber updated successfully"}, formats: :json, status: :ok
    else
      puts "Update unsuccessful"
    end
  end
end
