class Game < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :title, presence: true, length: { maximum: 50 }
end
