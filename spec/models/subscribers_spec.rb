# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subscriber, type: :model do
  subject { Subscriber.new(name: 'John Doe', status: 'active', email: 'john.doe@example.com') }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to allow_value('test@example.com').for(:email) }
  it { is_expected.not_to allow_value('test@example').for(:email) }

  describe 'before_validation' do
    context 'process_email' do
      it 'strips and downcases the email' do
        subscriber = Subscriber.new(email: '   TestEmail@example.com   ')
        subscriber.valid?
        expect(subscriber.email).to eq('testemail@example.com')
      end
    end

    context 'process_name' do
      it 'titleizes the name' do
        subscriber = Subscriber.new(name: 'john DOE')
        subscriber.valid?
        expect(subscriber.name).to eq('John Doe')
      end
    end
  end
end
