class ReviewsController < ApplicationController
  before_action :set_game_find

  def new
    @review = @game.reviews.build
  end

  def create
    @review = @game.reviews.build(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to game_url(@game), success: "感想・レビューを登録しました"
    else
      flash.now[:warning] = "登録できませんでした"
      render "new"
    end
  end

  def show
    @review = @game.reviews.find(params[:id])
  end

  def edit
    @review = @game.reviews.find(params[:id])
  end

  def update
    @review = @game.reviews.find(params[:id])
    if @review.update(review_params)
      redirect_to game_review_url, success: "編集しました"
    else
      flash.now[:warning] = "編集できませんでした"
      render "edit"
    end
  end

  def destroy
    @review = @game.reviews.find(params[:id])
    @review.destroy!
    redirect_to game_url(@game), success: "削除しました"
  end

  private

    def review_params
      params.require(:review).permit(:content)
    end

    def set_game_find
      @game = Game.find(params[:game_id])
    end
end
