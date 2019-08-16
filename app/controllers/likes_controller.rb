class LikesController < ApplicationController
  def create
    review = Review.find(params[:review_id])
    like = review.likes.create!(user_id: current_user.id)
    redirect_to review_url(review)
  end

  def destroy
    like = Like.find_by(user_id: current_user.id)
    like.destroy!
    redirect_to review_url
  end
end
