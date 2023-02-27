# frozen_string_literal: true

class Subscriber < ApplicationRecord
  validates :email, :status, presence: true
  validates :email, uniqueness: {case_sensitive: false},
    format: {with: URI::MailTo::EMAIL_REGEXP}

  enum status: {
    inactive: 0,
    active: 1
  }
end
