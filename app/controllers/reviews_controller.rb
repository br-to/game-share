class ReviewsController < ApplicationController
  before_action :set_game_find, only: [:new, :create]
  before_action :set_review_find, only: [:show, :edit, :update, :destroy]

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
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to review_url, success: "編集しました"
    else
      flash.now[:warning] = "編集できませんでした"
      render "edit"
    end
  end

  def destroy
    @review.destroy!
    redirect_to game_url(@review.game), success: "削除しました"
  end

  private

    def review_params
      params.require(:review).permit(:content)
    end

    def set_game_find
      @game = Game.find(params[:game_id])
    end

    def set_review_find
      @review = Review.find(params[:id])
    end
end
