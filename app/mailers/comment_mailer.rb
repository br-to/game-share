class CommentMailer < ApplicationMailer
  def commented_review(user)
    @user = user
    mail to: user.email, subject: "感想にコメントがつきました"
  end
end
