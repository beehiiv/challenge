require 'rails_helper'

RSpec.describe Subscriber, :type => :model do
  it "is valid with valid attributes" do
    expect(Subscriber.new(email: 'marys@email.com', name: 'Mary Smith', status: 'active')).to be_valid
    expect(Subscriber.new(email: 'maryj@email.com', name: 'Mary Jones', status: 'inactive' )).to be_valid
  end
end
