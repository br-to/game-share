class MicropostsController < ApplicationController
  before_action :set_game_find

  def new
    @micropost = @game.microposts.build
  end

  def create
    @micropost = @game.microposts.build(micropost_params)
    @micropost.user_id = current_user.id
    if @micropost.save
      redirect_to game_url(@game), success: "感想・レビューを登録しました"
    else
      flash.now[:warning] = "登録できませんでした"
      render "new"
    end
  end

  def show
    @micropost = @game.microposts.find(params[:id])
  end

  def edit
    @micropost = @game.microposts.find(params[:id])
  end

  def update
    @micropost = @game.microposts.find(params[:id])
    if @micropost.update(micropost_params)
      redirect_to game_micropost_url, success: "編集しました"
    else
      flash.now[:warning] = "編集できませんでした"
      render "edit"
    end
  end

  def destroy
    @micropost = @game.microposts.find(params[:id])
    @micropost.destroy
    redirect_to game_url(@game), success: "削除しました"
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def set_game_find
      @game = Game.find(params[:game_id])
    end
end
