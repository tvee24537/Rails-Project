class CommentsController < ApplicationController
  before_action :redirect_if_not_logged_in
  
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = current_user.posts.build(game_params)
    if @game.save
      redirect_to games_path
    else
      render :new
    end
  end
  
  private
  
  def game_params
    params.require(:game).permit(:title,:content)
  end
  
end