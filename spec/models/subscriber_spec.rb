require 'rails_helper'

RSpec.describe Subscriber, :type => :model do

  valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
  invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]

  # validations
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

  it "should accept valid email addresses" do
    subscriber = Subscriber.new(name: 'Mary Smith', status: 'inactive')
    valid_addresses.each do |valid_address|
      subscriber.email = valid_address
      assert subscriber.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  it "should not accept invalid email addresses" do
    subscriber = Subscriber.new(name: 'Mary Smith', status: 'inactive')
    invalid_addresses.each do |invalid_address|
      subscriber.email = invalid_address
      assert !subscriber.valid?, "#{invalid_address.inspect} should not be valid"
    end
  end

  it "should have a unique email address" do
    subscriber = Subscriber.new(email: "marysmith@email.com", name: 'Mary Smith', status: 'active')
    duplicate_subscriber = subscriber.dup
    subscriber.save
    assert !duplicate_subscriber.valid?
  end

  # email regex
  it "should return true for incorrect email address formats" do
    valid_addresses.each do |valid_address|
      assert valid_address.match?(Challenge::VALID_EMAIL_REGEX).eql?(true), "#{valid_address.inspect} should be true"
    end
  end

  it "should return false for incorrect email address formats" do
    invalid_addresses.each do |invalid_address|
      assert invalid_address.match?(Challenge::VALID_EMAIL_REGEX).eql?(false), "#{invalid_address.inspect} should be false"
    end
  end
end
