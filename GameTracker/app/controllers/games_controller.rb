class GamesController < ApplicationController
  before_action :redirect_if_not_logged_in
  
  def new
    if params[:user_id] && @user = User.find_by_id(params[:user_id])
      @games = @user.games.build
    else  
      @games = Game.new
    end
  end
  
  def create
    #create game to be rated and review
    @game = current_user.games.build(game_params)
    if @game.save
      redirect_to games_path
    else
      render :new
    end
  end
  
  def index
    if params[:user_id] && @user = User.find_by_id(params[:user_id]) #nested check
      @games = @user.games
    else  
      @error = "That user does not exist" if params[:user_id]
      @games = Game.all
    end
  end
  
  def show
    @game = Game.find_by_id(params[:id])
    redirect_to games_path if !@game
  end
  
  private
  
  def game_params
    params.require(:game).permit(:title,:content)
  end
  
end
