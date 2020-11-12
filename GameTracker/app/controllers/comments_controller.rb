class CommentsController < ApplicationController
  before_action :redirect_if_not_logged_in
  
  def index
    if params[:game_id] && @game = Game.find_by_id(params[:game_id]) #nested check
      @comments = @game.comments
    else  
      @error = "That game title does not exist" if params[:game_id]
      @comments = Comment.all
    end
  end
  
  def new
    if params[:game_id] && @game = Game.find_by_id(params[:game_id]) #nested check
      @comment = @game.comments.build
    else
      @error = "That game title does not exist" if params[:game_id]
      @comment = Comment.new
    end
  end
  
  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to comments_path
    else
      render :new
    end
  end
  
  def show
    @comment = Comment.find_by(id: params[:id])  
  end  
  
  def edit
    @comment = Comment.find_by(id: params[:id])  
  end  
  
  def update
    @comment = Comment.find_by(id: params[:id])  
    if @comment.update(comment_params)
      redirect_to comments_path(@comment)
    else
      render :edit
    end  
  end  
    
  private
  
  def comment_params
    params.require(:comment).permit(:content, :game_id)
  end
  
end