class GamesController < ApplicationController
  def new
    @game = current_user.games.build
  end

  def show
  end

  def create
    @game = current_user.games.build(game_params)
    if @game.save
      redirect_to user_path(current_user), success: "登録しました"
    else
      flash.now[:warning] = "登録できませんでした"
      render "new"
    end
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
