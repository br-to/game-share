class GamesController < ApplicationController
  def index
    @games = Game.order(created_at: :desc).page params[:page]
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
    @reviews = @game.reviews.unspoiled
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
