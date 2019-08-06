class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to profile_url, success: "ログインしました"
    else
      flash.now[:warning] = "ログインできませんでした"
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to root_url, info: "ログアウトしました"
  end
end
