require 'rails_helper'

RSpec.describe Subscriber, type: :model do
  # Basic validations
  it "is valid with valid attributes" do
    subscriber = Subscriber.new(name: "John Doe", email: "johndoe@example.com", status: "active")
    expect(subscriber).to be_valid
  end

  it "is not valid without a name" do
    subscriber = Subscriber.new(name: nil)
    expect(subscriber).to_not be_valid
  end

  it "is not valid without an email" do
    subscriber = Subscriber.new(email: nil)
    expect(subscriber).to_not be_valid
  end

  it "is not valid with an invalid email format" do
    subscriber = Subscriber.new(email: "invalid_email")
    expect(subscriber).to_not be_valid
  end

  it "is not valid if the email is not unique (case-insensitive)" do
    Subscriber.create(name: "Jane Doe", email: "janeDOE@example.com")
    subscriber = Subscriber.new(name: "Jane Doe", email: "janedoe@example.com")
    expect(subscriber).to_not be_valid
  end

  it "is not valid without a status" do
    subscriber = Subscriber.new(status: nil)
    expect(subscriber).to_not be_valid
  end

  it "is not valid with a status other than 'active' or 'inactive'" do
    subscriber = Subscriber.new(status: "pending")
    expect(subscriber).to_not be_valid
  end

  it "is valid with 'active' status" do
    subscriber = Subscriber.new(name: "John Doe", email: "john@example.com", status: "active")
    expect(subscriber).to be_valid
  end

  it "is valid with 'inactive' status" do
    subscriber = Subscriber.new(name: "John Doe", email: "john@example.com", status: "inactive")
    expect(subscriber).to be_valid
  end

  it "defaults to 'active' status when not provided" do
    subscriber = Subscriber.create(name: "John Doe", email: "johndoe@example.com")
    expect(subscriber.status).to eq("active")
  end
end
