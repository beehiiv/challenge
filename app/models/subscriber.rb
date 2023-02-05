class Subscriber < ApplicationRecord
  before_validation :normalize_email

  validates :email, email: true, presence: true, uniqueness: true
  validates :name,  presence: true

  private

  def normalize_email
    self.email = email.downcase.strip if email.present?
  end
end
