require 'spec_helper'

RSpec.describe Subscriber, type: :model do
  describe 'validations' do
    subject(:subscriber) do
      build :subscriber, email: email, name: name
    end

    let(:email) { 'john@example.com' }
    let(:name)  { 'John Doe' }

    context 'with valid attributes' do
      it 'is valid' do
        expect(subscriber).to be_valid
      end
    end

    context 'with an invalid name' do
      let(:name) { nil }

      it 'is not valid' do
        expect(subscriber).not_to be_valid
        expect(subscriber.errors[:name]).to include("can't be blank")
      end
    end

    context 'with an invalid email' do
      let(:email) { 'invalid' }

      it 'is not valid' do
        expect(subscriber).not_to be_valid
        expect(subscriber.errors[:email]).to include('is invalid')
      end
    end

    context 'with a duplicate email in uppercase' do
      let(:email) { create(:subscriber).email.upcase }

      it 'is not valid' do
        expect(subscriber).not_to be_valid
        expect(subscriber.errors[:email]).to include('has already been taken')
      end
    end
  end
end
