class SubscribersController < ApplicationController
  include PaginationMethods
  
  # GET /api/subscribers
  def index
    subscribers = Subscriber.all.limit(limit).offset(offset)
    total_records = Subscriber.count

    render json: {subscribers: subscribers, pagination: pagination(total_records)}, formats: :json
  end

  # POST /api/subscribers
  def create
    subscriber = Subscriber.new(subscriber_params)
    if subscriber.save
      render json: {message: "Subscriber created successfully"}, status: :created
    else
      render json: {errors: subscriber.errors}, status: :unprocessable_entity
    end
  end
  
  # PUT /api/subscribers/:id
  def update
    subscriber = Subscriber.find(params[:id])
    if subscriber.update(subscriber_params)
      render json: {message: "Subscriber updated successfully"}, status: :ok
    else
      render json: {errors: subscriber.errors}, status: :unprocessable_entity
    end
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:name, :email, :status)
  end
end
