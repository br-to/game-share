class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      log_in(@user)
      redirect_to profile_url, success: t(:user_registration_success, scope: :flash)
    else
      flash.now[:danger] = t(:registration_failed, scope: :flash)
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @games = @user.games
    @reviews = @user.reviews.includes(:game)
  end

  private

    def users_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
