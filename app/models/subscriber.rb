class Subscriber < ApplicationRecord
    before_save :downcase_email
  
    validates :name, :email, :status, presence: true
    validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :status, inclusion: { in: ['active', 'inactive'] }
  
    default_scope { order(created_at: :desc) }
  
    private
  
    def downcase_email
      self.email = email.downcase
    end
  end
  