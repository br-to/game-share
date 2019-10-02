class CommentMailer < ApplicationMailer
  def commented_review(user, review, comment)
    @user = user
    @review = review
    @comment = comment
    mail to: user.email, subject: "感想にコメントがつきました"
  end
end
