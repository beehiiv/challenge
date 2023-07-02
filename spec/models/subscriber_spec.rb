# spec/models/subscriber_spec.rb

require 'rails_helper'

RSpec.describe Subscriber, :type => :model do
  describe "validations" do
    it "is valid with valid attributes" do
      subscriber = Subscriber.new(name: 'foo', email: 'foo@bar.baz', status: 1)
      expect(subscriber).to be_valid
    end

    it "is valid with empty name" do
      subscriber = Subscriber.new(name: nil, email: 'foo@bar.baz', status: 1)
      expect(subscriber).to be_valid
    end
    
    it "is not valid without an email" do
      subscriber = Subscriber.new(email: nil)
      expect(subscriber).to_not be_valid
    end
    
    it "is not valid with an invalid email" do
      subscriber = Subscriber.new(email: 'foo')
      expect(subscriber).to_not be_valid
    end

    it "is not valid with an email with whitespaces" do
      subscriber = Subscriber.new(email: ' foo@bar.baz')
      expect(subscriber).to_not be_valid
      subscriber = Subscriber.new(email: 'foo@bar.baz ')
      expect(subscriber).to_not be_valid
      subscriber = Subscriber.new(email: ' foo@bar.baz ')
      expect(subscriber).to_not be_valid
      subscriber = Subscriber.new(email: 'foo @bar.baz')
      expect(subscriber).to_not be_valid
    end

    it "is not valid with a duplicate email" do
      subscriber_one = Subscriber.new(email: 'foo@bar.baz').save
      subscriber_two = Subscriber.new(email: 'foo@bar.baz')
      expect(subscriber_two).to_not be_valid
    end

    it "is not valid with an email with different casing" do
      subscriber_one = Subscriber.new(email: 'foo@bar.baz').save
      subscriber_two = Subscriber.new(email: 'Foo@Bar.Baz')
      expect(subscriber_two).to_not be_valid
    end
  end

  describe "defaults" do
    it "sets the status to inactive by default" do
      subscriber = Subscriber.new(email: 'foo@bar.baz')
      expect(subscriber.active?).to eq(false)
      expect(subscriber.inactive?).to eq(true)
    end
  end
end