class LikesController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @review = Review.find(params[:review_id])
    @like = current_user.likes.build(game_id: params[:game_id], review_id: params[:review_id])
    @like.save!
    redirect_to game_review_url(@game, @review)
  end

  def destroy
    @game = Game.find(params[:game_id])
    @review = Review.find(params[:review_id])
    @like = Like.find_by(game_id: params[:game_id], review_id: params[:review_id], user_id: current_user.id)
    @like.destroy!
    redirect_to game_review_url(@game, @review)
  end
end
