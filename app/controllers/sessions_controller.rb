class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in(user)
        redirect_to profile_url, success: t(:login_success, scope: :flash)
      else
        redirect_to root_url, warning: t(:invalid_link, scope: :flash)
      end
    else
      flash.now[:warning] = t(:login_failed, scope: :flash)
      render "new"
    end
  end

  def destroy
    log_out
    redirect_to root_url, success: t(:logout_success, scope: :flash)
  end
end
