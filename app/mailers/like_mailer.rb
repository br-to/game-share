class LikeMailer < ApplicationMailer
  def liked_review(user, review)
    @user = user
    @review = review
    mail to: user.email, subject: "感想がナイスされました"
  end
end
