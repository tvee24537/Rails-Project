module ReviewsHelper

  def display_header(review)
    if params[:restaurant_id]
      content_tag(:h1, "Add a Review for #{review.restaurant.name} -  #{review.restaurant.category.name}")
    else
      content_tag(:h1, "Create a review")
    end
  end
end
