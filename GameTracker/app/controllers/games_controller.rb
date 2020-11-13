class GamesController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :set_game, only: [:show, :edit, :update] 
  
  def new 
    @game = Game.new  
    @game.build_category 
  end 

  def create
    @game = Game.new(game_params) 
    @game.user_id = session[:user_id] 
   
    if @game.save 
      redirect_to game_path(@game) 
    else
      @game.build_category  
      render :new 
    end
  end

  def index   
    if params[:category_id]
      category = Category.find(params[:category_id])
      @games = category.games 
    else 
      @games = Game.order_by_rating.includes(:category) 
    end 
  end 

  def show 
    
  end 

  def edit 
    if authorized_to_edit?(@game) 
      render :edit   
    else 
      redirect_to game_path(@game)   
    end
  end 

  def update   
    if @game.update(game_params)
      redirect_to game_path(@game)
    else
      render :edit
    end 
  end 

  def most_popular 
    @games = Game.most_popular 
  end 

  private 

  def game_params
    params.require(:game).permit(:title, :price_range, :date_release, :category_id, category_attributes: [:title])
  end

  def set_game
    @game = Game.find_by(id: params[:id])
    redirect_to games_path if !@game 
  end

  def redirect_if_not_authorized 
    if @game.update(title: params[:title], price_range: params[:price_range], date_release: params[:date_release])   
      redirect_to game_path(@game)
    else
      redirect_to user_path(current_user)     
    end 
  end

end
