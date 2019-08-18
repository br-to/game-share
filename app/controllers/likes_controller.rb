class LikesController < ApplicationController
  def create
    review = Review.find(params[:review_id])
    like = current_user.likes.create!(review: review)
    redirect_to review_url(review.id)
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy!
    redirect_to review_url(like.review)
  end
end
