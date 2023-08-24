# frozen_string_literal: true

class Subscriber < ApplicationRecord
	ACTUAL_EMAIL_REGEX = /\A[a-zA-Z0-9.!\#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+\z/
	
	before_validation :process_email
	before_validation :process_name

  validates :name, presence: true 
  validates :status, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: ACTUAL_EMAIL_REGEX

	private

	def process_email
		self.email = email.strip.downcase if email
	end
	  
	def process_name
		self.name = name.titleize if name
	end
end
