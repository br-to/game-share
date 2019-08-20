class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  delegate :name, to: :user, prefix: true
  validates :content, presence: true, length: { maximum: 150 }
end
