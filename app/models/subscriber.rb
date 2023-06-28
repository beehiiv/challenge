class Subscriber < ApplicationRecord
  validates :email, presence: true, format: { with: Challenge::VALID_EMAIL_REGEX }
  validates :name, presence: true
  validates :status, presence: true
end
