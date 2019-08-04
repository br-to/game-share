class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      redirect_to user, success: "ログインしました"
    else
      flash.now[:warning] = "ログインできませんでした"
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, info: "ログアウトしました"
  end
end
