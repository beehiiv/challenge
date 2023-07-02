# frozen_string_literal: true

require "rails_helper"

RSpec.describe SubscribersController, type: :controller do
  before(:all) do
    @subscriber_one = Subscriber.new(email: 'foo@bar.baz')
    @subscriber_two = Subscriber.new(email: 'bar@baz.buz')
    @subscriber_one.save!
    @subscriber_two.save!
  end

  after(:all) do
    Subscriber.delete_all
  end
  
  describe "GET /subscribers" do
    it "returns 200 and a list of subscribers and pagination object" do
      get :index, params: {}, format: :json

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:subscribers].count).to eq(2)
      expect(json[:pagination]).not_to be_nil
    end
  end

  describe "POST /subscribers" do
    it "returns 201 if it successfully creates a subscriber" do
      post :create, params: {email: "test@test.com", name: "John Smith"}, format: :json

      expect(response).to have_http_status(:created)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json).to include({
        name: "John Smith",
        email: "test@test.com",
      })
    end

    it "returns 400 if there is an error" do
      post :create, params: {email: "foo@bar.baz"}, format: :json

      expect(response).to have_http_status(:bad_request)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json).to include({
        message: "Subscriber could not be created",
        errors: {
          email: ["Please provide a unique email address"]
        }
      })
    end
  end

  describe "PATCH /subscribers/:id" do
    it "returns 200 if it successfully updates a subscriber" do
      patch :update, params: {id: @subscriber_one[:id], status: "active"}, format: :json

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json).to include({
        status: 'active'
      })
    end

    it "returns 404 if there is a missing subscriber" do
      patch :update, params: {id: 'foo', status: "inactive"}, format: :json

      expect(response).to have_http_status(:not_found)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json).to include({
        message: 'Subscriber could not be found'
      })
    end

    it "returns 400 and ignores invalid status value" do
      patch :update, params: {id: @subscriber_one[:id], status: "foo"}, format: :json

      expect(response).to have_http_status(:bad_request)
      expect(response.content_type).to eq("application/json; charset=utf-8")

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json).to include({
        message: "Subscriber could not be updated",
        errors: {
          unknown: "'foo' is not a valid status"
        }
      })

      @subscriber_one.reload
      expect(@subscriber_one.inactive?).to eq(true)
    end
  end
end
