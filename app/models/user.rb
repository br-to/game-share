class User < ApplicationRecord
  before_save :downcase_email
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password

  private

    def downcase_email
      email.downcase!
    end
end
