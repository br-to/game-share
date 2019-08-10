class Game < ApplicationRecord
  belongs_to :user
  has_many :microposts, dependent: :destroy
  validates :title, presence: true, length: { maximum: 50 }
  scope :created_at_order, -> { order(created_at: :desc) }
end
