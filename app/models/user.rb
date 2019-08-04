class User < ApplicationRecord
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 50 }
  has_secure_password
end
