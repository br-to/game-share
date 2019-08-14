class ProfilesController < ApplicationController
  def show
  end

  def edit
  end

  def update
    if current_user.update(users_params)
      redirect_to profile_url, success: "更新しました"
    else
      flash.now[:warning] = "編集できませんでした"
      render "edit"
    end
  end

  def destroy
    current_user.destroy!
    redirect_to root_url, success: "ユーザー削除"
  end

  private

    def users_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
