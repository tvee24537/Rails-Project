class CommentsController < ApplicationController
  before_action :redirect_if_not_logged_in
  
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to comments_path
    else
      render :new
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
  
end