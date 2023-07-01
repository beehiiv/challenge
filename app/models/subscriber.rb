# Email validation inspired from:
# https://www.w3resource.com/javascript/form/email-validation.php#:~:text=To%20get%20a%20valid%20email,%5D%2B)*%24%2F.

class Subscriber < ApplicationRecord
    validates :email, {
        presence: { message: 'Please provide an email'},
        format: { with: /\A\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})\z+/, multiline: false, message: 'Please provide a valid email' },
        uniqueness: { case_sensitive: false, message: 'Please provide a unique email' }
    }
    enum status: { inactive: 0, active: 1 }
end
