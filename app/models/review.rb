class Review < ApplicationRecord
  belongs_to :user
  belongs_to :game
  delegate :name, to: :user, prefix: true
  delegate :title, to: :game, prefix: true
  validates :content, presence: true, length: { maximum: 255 }
end
