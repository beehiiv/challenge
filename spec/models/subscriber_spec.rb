# frozen_string_literal: true

require "rails_helper"

RSpec.describe Subscriber, type: :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to define_enum_for(:status).with_values(inactive: 0, active: 1) }

  context "with uniqueness validations" do
    subject { build(:subscriber) }

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end

  context "with different email formats" do
    subject(:subscriber) { build(:subscriber, email:) }

    context "when an email exists with whitespace" do
      let(:email) { "  test@test.com  " }

      it { is_expected.to be_invalid }
    end

    context "when email address is invalid" do
      let(:email) { "testtestcom" }

      it { is_expected.to be_invalid }
    end

    context "when email address is valid" do
      let(:email) { "test@test.com" }

      it { is_expected.to be_valid }
    end
  end
end
