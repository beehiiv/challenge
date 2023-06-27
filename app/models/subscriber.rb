class Subscriber < ApplicationRecord
  enum status: {active: 0, inactive: 1}
  before_save :downcase_email
  validates :email, presence: true, uniqueness: {case_sensitive: false},
    format: {with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email address"}
  validate :email_does_not_contain_whitespace

  private

  def downcase_email
    self.email = email.downcase
  end

  def email_does_not_contain_whitespace
    if email && email.match(/\s/)
      errors.add(:email, "cannot contain whitespace")
    end
  end
end
