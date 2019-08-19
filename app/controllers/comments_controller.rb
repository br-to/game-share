class CommentsController < ApplicationController
  def create
    review = Review.find(params[:review_id])
    comment = review.comments.build(params_comment)
    comment.user_id = current_user.id
    if comment.save
      redirect_to review_url(review.id), success: "コメントしました"
    else
      render "reviews/show"
      flash.now[:warning] = "コメントできません"
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy!
    redirect_to review_url(comment.review), success: "コメントを削除しました"
  end

  private

    def params_comment
      params.require(:comment).permit(:content)
    end
end
