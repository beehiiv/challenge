class Subscriber < ApplicationRecord

  scope :by_recently_created, -> { order(created_at: :desc) }

  before_save { self.email = self.email.downcase }

  validates :email, presence: true, format: { with: Challenge::VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :status, presence: true, inclusion: ['active', 'inactive']
end
