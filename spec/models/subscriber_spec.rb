require 'rails_helper'

RSpec.describe Subscriber, :type => :model do
  it "is valid with valid attributes" do
    expect(Subscriber.new(email: 'marys@email.com', name: 'Mary Smith', status: 'active')).to be_valid
    expect(Subscriber.new(email: 'maryj@email.com', name: 'Mary Jones', status: 'inactive' )).to be_valid
  end

    it "is not valid without an email" do
    subscriber = Subscriber.new(email: nil)
    expect(subscriber).to_not be_valid
  end

  it "is not valid without a name" do
    subscriber = Subscriber.new(name: nil)
    expect(subscriber).to_not be_valid
  end

  it "is not valid without a status" do
    subscriber = Subscriber.new(status: nil)
    expect(subscriber).to_not be_valid
  end
end
