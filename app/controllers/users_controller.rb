class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update]
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(users_params)
      redirect_to @user, success: "編集しました"
    else
      flash.now[:warning] = "編集できませんでした"
      render "edit"
    end
  end

  def destroy
    User.destroy(params[:id])
    redirect_to root_url, danger: "ユーザーを削除しました"
  end

  private

    def users_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def ensure_correct_user
      @user = User.find(params[:id])
      redirect_to(login_url) unless current_user?(@user)
    end
end
