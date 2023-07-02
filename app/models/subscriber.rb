# Email validation inspired from:
# https://www.w3resource.com/javascript/form/email-validation.php#:~:text=To%20get%20a%20valid%20email,%5D%2B)*%24%2F.

class Subscriber < ApplicationRecord
    enum status: { inactive: 0, active: 1 }
    validates :status, inclusion: { in: statuses.keys }
    validates :email, {
        format: { with: /\A\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})\z+/, multiline: false, message: 'Please provide a valid email address' },
        uniqueness: { case_sensitive: false, message: 'Please provide a unique email address' }
    }
end
