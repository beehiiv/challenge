class Subscriber < ApplicationRecord
	before_validation :process_email
	before_validation :process_name

  validates :name, presence: true 
  validates :status, presence: true
  validates :email, presence: true, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP

	private

	def process_email
		self.email.strip.downcase
	end

	def process_name
		self.titleize
	end
end
