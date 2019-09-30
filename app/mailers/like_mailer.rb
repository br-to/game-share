class LikeMailer < ApplicationMailer
  def liked_review(user)
    @user = user
    mail to: user.email, subject: "感想がナイスされました"
  end
end
