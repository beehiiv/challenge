require 'rails_helper'
require 'factory_bot'

RSpec.describe Subscriber, type: :model do
  subject(:subscriber1) { FactoryBot.build(:subscriber, name: 'John Doe', email: 'john@example.com') }
  subject(:subscriber2) { FactoryBot.build(:subscriber, name: 'Jane Smith', email: 'jane@example.com') }

  describe 'validations' do
    it 'succeeds when email is unique' do
      expect(subscriber1).to be_valid
    end

    it 'succeeds when name is present' do
      expect(subscriber1).to be_valid
    end

    it 'fails when email is not unique' do
      subscriber1.save
      subscriber2.email = subscriber1.email
      expect(subscriber2).not_to be_valid
      expect(subscriber2.errors[:email]).to include('has already been taken')
    end

    it 'fails when name is not present' do
      subscriber2.name = nil
      expect(subscriber2).not_to be_valid
      expect(subscriber2.errors[:name]).to include("can't be blank")
    end

    it 'fails when email is not a valid email address' do
      subscriber1.email = 'invalid_email'
      expect(subscriber1).not_to be_valid
      expect(subscriber1.errors[:email]).to include('is not a valid email address')
    end

    it 'fails when email contains whitespace' do
      subscriber1.email = 'john @example.com'
      expect(subscriber1).not_to be_valid
      expect(subscriber1.errors[:email]).to include('cannot contain whitespace')
    end
  end
end
