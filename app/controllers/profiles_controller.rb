class ProfilesController < ApplicationController
  skip_before_action :authenticate_user, only: [:destoy]
  before_action :set_current_user

  def destroy
    @current_user.destroy
    redirect_to root_url, success: "ユーザー削除"
  end

  private

    def set_current_user
      @current_user = User.find_by(id: session[:user_id])
    end
end
