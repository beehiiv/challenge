class Subscriber < ApplicationRecord
  validates :email, presence: true, uniqueness: { case_sensitive: false }, on: :create
end
