class CommentsController < ApplicationController
  def create
    @review = Review.find(params[:review_id])
    @comment = @review.comments.build(params_comment)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to review_url(@review), success: "コメントしました"
    else
      flash.now[:warning] = "コメントできません"
      @like = @review.likes.find_by(user: current_user)
      @comment = @review.comments.build
      @comments = @review.comments.includes(:user)
      render "reviews/show"
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
    redirect_to review_url(@comment.review), success: "コメントを削除しました"
  end

  private

    def params_comment
      params.require(:comment).permit(:content)
    end
end
