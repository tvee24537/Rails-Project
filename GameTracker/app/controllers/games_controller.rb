class GamesController < ApplicationController
  before_action :redirect_if_not_logged_in
  
  def new
    @game = Game.new
  end
  
  def create
    #create game to be rated and review
    @game = current_user.posts.build(game_params)
    if @game.save
      redirect_to games_path
    else
      render :new
    end
  end
  
  private
  
  def post_params
    params.require(:game).permit(:title,:content)
  end
  
end
