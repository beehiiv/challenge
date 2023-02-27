# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Subscribers", type: :request do
  describe "GET subscribers#index" do
    let(:headers) { { "Content-Type": "application/json" } }
    let(:sub1) { create(:subscriber) }
    let(:sub2) { create(:subscriber) }
    let(:sub3) { create(:subscriber) }
    let!(:subscribers) { [sub1, sub2, sub3] }

    context "without a page or per_page" do
      it "returns all subscribers" do
        get("/subscribers", headers:)

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body["subscribers"]).to match_array subscribers.map(&:attributes).as_json
      end
    end

    context "with a per_page" do
      it "returns subscribers within the limit" do
        get("/subscribers?per_page=1", headers:)

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body["subscribers"]).to eq [sub1.attributes.as_json]
      end
    end

    context "with a page and per_page" do
      it "returns subscribers within the limit" do
        get("/subscribers?page=2&per_page=1", headers:)

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body["subscribers"]).to eq [sub2.attributes.as_json]
      end
    end
  end

  describe "POST subscribers#create" do
    let(:headers) { { "Content-Type": "application/json" } }
    let(:subscriber) { Subscriber.first }

    context "with valid attributes" do
      let(:user_params) { { name: Faker::Name.name, email: Faker::Internet.email } }

      it "creates the subscriber" do
        post("/subscribers", params: user_params.to_json, headers:)

        expect(response).to have_http_status :created
        expect(response.parsed_body).to eq("message" => "Subscriber created successfully")

        expect(subscriber.name).to eq user_params[:name]
        expect(subscriber.email).to eq user_params[:email]
        expect(subscriber).to be_inactive
      end
    end

    context "with invalid attributes" do
      let(:user_params) { { name: "", email: "" } }
      let(:expected) do
        {
          "message" => {
            "email" => ["can't be blank", "is invalid"]
          }
        }
      end

      it "does not create the subscriber" do
        post("/subscribers", params: user_params.to_json, headers:)

        expect(response).to have_http_status :not_acceptable
        expect(response.parsed_body).to eq expected
        expect(subscriber).to be_nil
      end
    end
  end

  describe "PATCH subscribers#update" do
    let(:headers) { { "Content-Type": "application/json" } }
    let!(:subscriber) { create(:subscriber, status: :inactive) }

    context "with valid attributes" do
      let(:user_params) { { name: Faker::Name.name, email: Faker::Internet.email, status: :active } }

      it "updates the subscriber" do
        patch("/subscribers/#{subscriber.id}", params: user_params.to_json, headers:)

        subscriber.reload

        expect(response).to have_http_status :ok
        expect(response.parsed_body).to eq("message" => "Subscriber updated successfully")

        expect(subscriber.name).to eq user_params[:name]
        expect(subscriber.email).to eq user_params[:email]
        expect(subscriber).to be_active
      end
    end

    context "with invalid attributes" do
      let(:user_params) { { name: "", email: "", status: :active } }

      let(:expected) do
        {
          "message" => {
            "email" => ["can't be blank", "is invalid"]
          }
        }
      end

      it "does not update the subscriber" do
        patch("/subscribers/#{subscriber.id}", params: user_params.to_json, headers:)

        subscriber.reload

        expect(response).to have_http_status :not_acceptable
        expect(response.parsed_body).to eq expected

        expect(subscriber.name).not_to eq user_params[:name]
        expect(subscriber.email).not_to eq user_params[:email]
        expect(subscriber).not_to be_active
      end
    end
  end
end
