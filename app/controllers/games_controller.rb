class GamesController < ApplicationController
  skip_before_action :authenticate_user, only: [:index, :show]
  def index
    @games = Game.order(created_at: :desc).includes(:user).page(params[:page]).per(10)
  end

  def new
    @game = current_user.games.build
  end

  def create
    @game = current_user.games.build(game_params)
    if @game.save
      redirect_to games_url, success: t(:game_registration_success, scope: :flash)
    else
      flash.now[:warning] = t(:registration_failed, scope: :flash)
      render "new"
    end
  end

  def show
    @game = Game.find(params[:id])
    @reviews = @game.reviews.where(is_spoiled: false).includes(:user, { comments: :user })
  end

  def edit
    @game = current_user.games.find(params[:id])
  end

  def update
    @game = current_user.games.find(params[:id])
    if @game.update(game_params)
      redirect_to game_url, success: t(:game_update_success, scope: :flash)
    else
      flash.now[:warning] = t(:update_failed, scope: :flash)
      render "edit"
    end
  end

  def destroy
    @game = current_user.games.find(params[:id])
    @game.destroy!
    redirect_to games_url, success: t(:game_destroy_success, scope: :flash)
  end

  private

    def game_params
      params.require(:game).permit(:title, :picture)
    end
end
