class AccountActivationsController < ApplicationController
  skip_before_action :authenticate_user, only: :edit
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
      log_in(user)
      redirect_to profile_url, success: t(:account_activation, scope: :flash)
    else
      redirect_to root_url, info: t(:invalid_link, scope: :flash)
    end
  end
end
