class ProfilesController < ApplicationController
  def show
  end

  def edit
  end

  def update
    if current_user.update(users_params)
      redirect_to profile_url, success: t(:user_update_success, scope: :flash)
    else
      flash.now[:warning] = t(:update_failed, scope: :flash)
      render "edit"
    end
  end

  def destroy
    current_user.destroy!
    redirect_to root_url, success: t(:user_destroy_success, scope: :flash)
  end

  private

    def users_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :user_picture)
    end
end
