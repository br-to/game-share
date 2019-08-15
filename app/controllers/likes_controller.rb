class LikesController < ApplicationController
  def create
    @review = Review.find(params[:review_id])
    @like = current_user.likes.build(review_id: params[:review_id])
    @like.save!
    redirect_to review_url(@review)
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id)
    @like.destroy!
    redirect_to review_url
  end
end
