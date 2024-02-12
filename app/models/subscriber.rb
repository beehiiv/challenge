# frozen_string_literal: true

class Subscriber < ApplicationRecord

	before_validation :process_email
	before_validation :process_name

  validates :name, presence: true 
  validates :status, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP } 

	private

	def process_email
		self.email = email.strip.downcase if email
	end

	def process_name
		self.name = name.titleize if name
	end
end