class CategoriesController < ApplicationController
  before_action :redirect_if_not_logged_in

  # category index uses scope to sort by alphabetical order
  def index 
    @categories = Category.alpha 
  end 
end
