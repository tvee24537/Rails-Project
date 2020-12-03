module ApplicationHelper
  # display part of nav bar if logged in, other part for home page
  def render_nav_bar
    if logged_in?
      render partial: 'layouts/loggedin_links'
    else
      render partial: 'layouts/loggedout_links'
    end
  end
end
