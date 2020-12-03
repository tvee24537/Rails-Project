class GamesController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :set_game, only: [:show, :edit, :update] 
  
  # make new game
  def new 
    @game = Game.new  
    @game.build_category 
  end 
  # save new game with existing category or make a new category
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
  # index for cateory uses scope to sort games in each category by rating
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
  # edit game function
  def edit 
    if authorized_to_edit?(@game) 
      render :edit   
    else 
      redirect_to game_path(@game)   
    end
  end 
  # update the change in the edit
  def update   
    if @game.update(game_params)
      redirect_to game_path(@game)
    else
      render :edit
    end 
  end 
  # rate game
  def most_popular 
    @games = Game.most_popular 
  end 
  
  private 
  # parameter for game
  def game_params
    params.require(:game).permit(:name, :price_range, :release_date, :category_id, category_attributes: [:name])
  end
  # find game
  def set_game
    @game = Game.find_by(id: params[:id])
    redirect_to games_path if !@game 
  end
  # redirect if not own by current user
  def redirect_if_not_authorized 
    if @game.update(name: params[:name], price_range: params[:price_range], release_date: params[:release_date])   
      redirect_to game_path(@game)
    else
      redirect_to user_path(current_user)     
    end 
  end

end
