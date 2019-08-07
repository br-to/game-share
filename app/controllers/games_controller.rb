class GamesController < ApplicationController
  def index
    @games = Game.all.order(created_at: :desc)
  end

  def new
    @game = current_user.games.build
  end

  def create
    @game = current_user.games.build(game_params)
    if @game.save
      redirect_to games_path, success: "登録しました"
    else
      flash.now[:warning] = "登録できませんでした"
      render "new"
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def game_params
      params.require(:game).permit(:title)
    end
end
