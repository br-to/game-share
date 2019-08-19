class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  validates :content, presence: true, length: { maximum: 150 }
end
