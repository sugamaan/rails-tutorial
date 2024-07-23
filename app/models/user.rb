class User < ApplicationRecord
  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password
end
