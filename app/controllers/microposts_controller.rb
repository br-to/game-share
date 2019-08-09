class MicropostsController < ApplicationController
  def new
    @game = Game.find(params[:game_id])
    @micropost = @game.microposts.build
  end

  def create
    @game = Game.find(params[:game_id])
    @micropost = @game.microposts.build(micropost_params)
    @micropost.user_id = current_user.id
    if @micropost.save
      redirect_to game_path(@game), success: "感想・レビューを登録しました"
    else
      flash.now[:warning] = "登録できませんでした"
      render "new"
    end
  end

  def show
    @micropost = Micropost.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end
end
