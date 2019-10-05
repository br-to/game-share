class Review < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  delegate :name, to: :user, prefix: true
  delegate :title, to: :game, prefix: true
  validates :content, presence: true, length: { maximum: 255 }
  scope :spoiled, -> { where(is_spoiled: true).includes(:user, { comments: :user }) }
  scope :unspoiled, -> { where(is_spoiled: false).includes(:user, { comments: :user }) }

  def liked_by?(user)
    likes.find_by(user: user).present?
  end
end
