require 'rails_helper'

RSpec.describe Subscriber, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value("test@example.com").for(:email) }
    it { should_not allow_value("invalid_email").for(:email) }
  end

  describe "callbacks" do
    it "downcases and strips email before validation" do
      subscriber = build(:subscriber, email: " Test@Example.com ")
      subscriber.valid?
      expect(subscriber.email).to eq("test@example.com")
    end

    it "titleizes name before validation" do
      subscriber = build(:subscriber, name: "john doe")
      subscriber.valid?
      expect(subscriber.name).to eq("John Doe")
    end
  end
end
