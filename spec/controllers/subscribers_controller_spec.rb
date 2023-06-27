# frozen_string_literal: true

require "rails_helper"

RSpec.describe SubscribersController, type: :controller do
  describe "GET /subscribers" do
    it "returns 200 and a list of subscribers and pagination object" do
      get :index, params: {}, format: :json

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:subscribers]).not_to be_nil
      expect(json[:pagination]).not_to be_nil
    end
  end

  describe "POST /subscribers" do
    it "returns 201 if it successfully creates a subscriber" do
      post :create, params: {subscriber: {email: "test@test.com", name: "John Smith"}}, format: :json

      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:message]).to eq "Subscriber created successfully"
    end

    it "returns 422 if the subscriber is not valid" do
      post :create, params: { subscriber: { email: "", name: "John Smith" } }, format: :json

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:errors]).to include("Email can't be blank")
    end

  end

  describe "PATCH /subscribers/:id" do
    it "returns 200 if it successfully updates a subscriber" do
      # create a subscriber
      subscriber = Subscriber.create(email: "test@test.com", name: "John Doe")

      # update the subscriber's status
      patch :update, params: {id: subscriber.id, subscriber: {status: "inactive"}}, format: :json

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:message]).to eq "Subscriber updated successfully"
    end

    it "returns 422 if the update fails due to validation errors" do
      subscriber = Subscriber.create(email: "test@test.com", name: "John Doe")

      patch :update, params: { id: subscriber.id, subscriber: { email: "" } }, format: :json

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:errors]).to include("Email can't be blank")

      subscriber.reload
      expect(subscriber.email).to eq("test@test.com")
    end

    it "returns 404 if the subscriber is not found" do
      patch :update, params: { id: 999, subscriber: { name: "Jane Smith" } }, format: :json

      expect(response).to have_http_status(:not_found)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:errors]).to eq(["Subscriber not found"])
    end
  end
end
