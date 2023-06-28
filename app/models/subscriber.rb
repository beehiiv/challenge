class Subscriber < ApplicationRecord
  before_save { self.email = self.email.downcase }

  validates :email, presence: true, format: { with: Challenge::VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :status, presence: true
end
