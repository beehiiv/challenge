# frozen_string_literal: true

class Subscriber < ApplicationRecord
	NAME_REGEX = /\A[a-z0-9\s-]+\z/i

	before_validation :process_email
	before_validation :process_name

  validates :name, presence: true, format: {with: NAME_REGEX, message: "can only contain letters, numbers, spaces and hyphens"} 
  validates :status, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP, message: "invalid email"} 

	private

	def process_email
		self.email = email.strip.downcase if email
	end

	def process_name
		self.name = name.titleize if name
	end
end