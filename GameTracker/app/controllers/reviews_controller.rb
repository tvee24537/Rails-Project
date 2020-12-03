class ReviewsController < ApplicationController
  before_action :redirect_if_not_logged_in
  # check if game exist by id and make review
  def new
    if @game = Game.find_by_id(params[:game_id])
      @review = @game.reviews.build
    else
      @review = Review.new
    end
  end
  # check if review saves and redirect to view page or redirect to review new page again if it doesn't save
  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to review_path(@review)
    else
      render :new
    end
  end
  # function to show review by id
  def show
    @review = Review.find_by_id(params[:id])
  end
   # find review by id or list all reviews 
  def index
    if @game = Game.find_by_id(params[:game_id])
      @reviews = @game.reviews
    else
      @reviews = Review.all
    end
  end

  private 
  # parameters of reviews
  def review_params
    params.require(:review).permit(:game_id, :content, :stars, :title)  
  end 

end