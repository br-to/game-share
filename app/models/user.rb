class User < ApplicationRecord
  has_many :games, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_review, through: :likes, source: :review
  before_save :downcase_email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
  mount_uploader :image, PictureUploader

  private

    def downcase_email
      email.downcase!
    end
end
