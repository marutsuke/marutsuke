class CommentsController < UserBase

  def image_show
    @answer = current_user.answers.find(params[:answer_id])
    @comment = @answer.comments.find(params[:id])
    @comment_image = @comment.image
    respond_to { |format| format.js }
  end

end
