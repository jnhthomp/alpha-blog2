class PagesController < ApplicationController

  # Loads pages/home.html.erb
  def home
    # Uses logged_in? from application controller to check if a user is logged in or not
    #   If they are logged in then it will redirect to the articles_path (articles#index)
    #   (home page unavailable for logged in users)
    redirect_to articles_path if logged_in?
  end

  # Loads pages/about.html.erb (empty)
  def about
    
  end
end
