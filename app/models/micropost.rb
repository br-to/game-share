class Micropost < ApplicationRecord
  belongs_to :user
  belongs_to :game
  validates :content, presence: true, length: { maximum: 255 }
end
