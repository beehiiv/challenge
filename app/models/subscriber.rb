class Subscriber < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP, message: "invalid email" }
    validates :status, inclusion: { in: ['active', 'inactive'] }
  end
  
