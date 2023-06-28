class Subscriber < ApplicationRecord
  validates :email, presence: true
  validates :name, presence: true
  validates :status, presence: true
end
