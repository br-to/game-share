class CommentsController < ApplicationController
  def create
    @review = Review.find(params[:review_id])
    @comment = @review.comments.build(params_comment)
    @comment.user = current_user
    if @comment.save
      CommentMailer.commented_review(@review.user, @review, @comment).deliver_now
      redirect_to review_url(@review), success: t(:comment_registration_success, scope: :flash)
    else
      flash.now[:warning] = t(:registration_failed, scope: :flash)
      @like = @review.likes.find_by(user: current_user)
      @comments = @review.comments.includes(:user)
      render "reviews/show"
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
    redirect_to review_url(@comment.review), success: t(:comment_destroy_success, scope: :flash)
  end

  private

    def params_comment
      params.require(:comment).permit(:content)
    end
end
