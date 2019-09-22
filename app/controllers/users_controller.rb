class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:success] = t(:mail_check, scope: :flash)
      redirect_to root_url
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
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end
end
