class Subscriber < ApplicationRecord
  enum status: {active: 0, inactive: 1}

  before_validation :normalize_email

  validates :email, email: true, presence: true, uniqueness: true
  validates :name, presence: true

  private

  def normalize_email
    self.email = email.downcase.strip if email.present?
  end
end
