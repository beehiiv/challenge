class Subscriber < ApplicationRecord
    validates :name, presence: true 
    validates :email, presence: true, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP
    validates :status, presence: true
end
