class ReviewsController < ApplicationController
  before_action :set_game_find, only: [:index, :new, :create]
  before_action :set_review_find, only: [:show, :edit, :update, :destroy]

  def index
    @reviews = @game.reviews.where(is_spoiled: true).includes(:user, { comments: :user })
  end

  def new
    @review = @game.reviews.build
  end

  def create
    @review = @game.reviews.build(review_params)
    @review.user_id = current_user.id
    if @review.save
      if @review.is_spoiled?
        redirect_to game_reviews_url(@game), success: t(:spoiler_registration_success, scope: :flash)
      else
        redirect_to game_url(@game), success: t(:review_registration_success, scope: :flash)
      end
    else
      flash.now[:warning] = t(:registration_failed, scope: :flash)
      render "new"
    end
  end

  def show
    @like = @review.likes.find_by(user: current_user)
    @comment = @review.comments.build
    @comments = @review.comments.includes(:user)
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to review_url(@review), success: t(:review_update_success, scope: :flash)
    else
      flash.now[:warning] = t(:update_failed, scope: :flash)
      render "edit"
    end
  end

  def destroy
    @review.destroy!
    redirect_to game_url(@review.game), success: t(:review_destroy_success, scope: :flash)
  end

  private

    def review_params
      params.require(:review).permit(:content, :is_spoiled)
    end

    def set_game_find
      @game = Game.find(params[:game_id])
    end

    def set_review_find
      @review = Review.find(params[:id])
    end
end
