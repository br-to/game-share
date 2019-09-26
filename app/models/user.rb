class User < ApplicationRecord
  attr_accessor :activation_token
  has_many :games, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_review, through: :likes, source: :review
  before_save :downcase_email
  before_create :create_activation_digest
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, presence: { presence: true, allow_nil: true }, length: { minimum: 6, allow_nil: true }
  has_secure_password
  mount_uploader :image, PictureUploader

  def self.digest(string)
    cost =
      if Rails.env.test?
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end

  def self.generate_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  private

    def downcase_email
      email.downcase!
    end

    def create_activation_digest
      self.activation_token = User.generate_token
      self.activation_digest = User.digest(activation_token)
    end
end
