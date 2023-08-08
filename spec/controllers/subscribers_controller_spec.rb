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

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_params) { { subscriber: { name: "Sam Smith", email: "sam@example.com" } } }

      it "creates a new subscriber" do
        expect {
          post :create, params: valid_params
        }.to change(Subscriber, :count).by(1)
        expect(response.status).to eq(201)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) { { subscriber: { name: "", email: "" } } }

      it "does not create a subscriber and returns an error" do
        expect {
          post :create, params: invalid_params
        }.not_to change(Subscriber, :count)
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT #update" do
    let(:subscriber) { Subscriber.create(name: "Jack Brown", email: "jack@example.com", status: "active") }

    context "with valid id" do
      it "updates a subscriber's status" do
        put :update, params: { id: subscriber.id }
        subscriber.reload
        expect(subscriber.status).to eq("inactive")
        expect(response.status).to eq(200)
      end
    end

    context "with invalid id" do
      it "returns not found" do
        put :update, params: { id: -1 }
        expect(response.status).to eq(404)
      end
    end
  end
end
