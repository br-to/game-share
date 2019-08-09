class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      log_in(@user)
      redirect_to profile_path, success: "登録しました"
    else
      flash.now[:danger] = "登録できませんでした"
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @games = @user.games
  end

  private

    def users_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
