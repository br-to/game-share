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
    @game = current_user.games.find(params[:id])
  end

  def update
    @game = current_user.games.find(params[:id])
    if @game.update(game_params)
      redirect_to game_url, success: "編集しました"
    else
      flash.now[:warning] = "編集できませんでした"
      render "edit"
    end
  end

  def destroy
    @game = current_user.games.find(params[:id])
    @game.destroy
    redirect_to games_url, success: "削除しました"
  end

  private

    def game_params
      params.require(:game).permit(:title)
    end
end
