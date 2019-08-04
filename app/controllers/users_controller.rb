class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      log_in(@user)
      redirect_to @user, success: "登録しました"
    else
      flash.now[:danger] = "登録できませんでした"
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

    def users_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
