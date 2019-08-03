class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(users_params)
    if @user.save
      flash[:success] = "登録しました"
      redirect_to @user
    else
      flash[:danger] = "登録できませんでした"
      render "new"
    end
  end

  private

    def users_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
