class LikesController < ApplicationController
  def create
    review = Review.find(params[:review_id])
    current_user.likes.create!(review: review)
    LikeMailer.liked_review(review.user, review).deliver_now
    redirect_to review_url(review)
  end

  def destroy
    like = current_user.likes.find(params[:id])
    like.destroy!
    redirect_to review_url(like.review)
  end
end
