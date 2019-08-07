class ApplicationController < ActionController::Base
  before_action :authenticate_user
  helper_method :current_user, :logged_in?
  add_flash_types :success, :info, :warning, :danger

  private

    def authenticate_user
      unless logged_in?
        redirect_to login_url, warning: "ログインしてください"
      end
    end

    def log_in(user)
      session[:user_id] = user.id
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def current_user?(user)
      user == current_user
    end

    def logged_in?
      current_user.present?
    end

    def log_out
      session.delete(:user_id)
      @current_user = nil
    end
end
