class Like < ApplicationRecord
  belongs_to :user
  belongs_to :game, optional: true
  belongs_to :review
end
