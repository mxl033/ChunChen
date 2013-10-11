require "model_validators"

class User < ActiveRecord::Base

  validates :name,  presence: true, uniqueness: true
  validates :email, presence: true, email_format: true, uniqueness: true
  validates :password, length: { in: 6..20 }, password_format: true

  has_secure_password
end
