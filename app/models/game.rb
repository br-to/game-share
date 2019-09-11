class Game < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  validates :title, presence: true, length: { maximum: 50 }
  mount_uploader :game_picture, PictureUploader
end
