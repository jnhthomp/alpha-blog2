class ArticlesController < ApplicationController
  # Set @article var when viewing a page for/performing action on a single article
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # Require a user to be logged in to perform any actions or view pages that are not article/show or article/index
  before_action :require_user, except: [:show, :index]
  # Require a user be assigned to an article or an admin to manipulate an article or view its edit page
  before_action :require_same_user, only:[:edit, :update, :destroy]

  # Load page to view individual article
  def show
    
  end

  # Load listing of all created articles
  def index
    # @articles will hold list of all articles (all being how many is selected for pagination)
    # functionality provided by will_paginate gem
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  # Create new article page
  def new
    # Initialize new Article obj
    # Will be updated from the view before @article is pushed to #create
    @article = Article.new
  end

  # Edit article page
  # receives @article from params/show page when navigated to
  def edit
    
  end

  # Create a new article from new article page
  def create
    # update @article with values from new
    @article = Article.new(article_params)
    # Set @article.user w/ logged in user
    @article.user = current_user
    # Attempt to save article object
    if @article.save
      # successful article save flash message
      flash[:notice] = "Article was created successfully"
      # show created article page on successful save
      redirect_to @article
    else
      # Re-render new article page if there is an error creating
      # Errors are attached to @article and rendered with shared/_errors from _form in new 
      render 'new'
    end
  end

  # Update an existing article from edit page
  def update
    # Receive new values from params and attempt to update article
    if @article.update(article_params)
      # Successfull article update flash message
      flash[:notice] = "Article was updated successfully"
      # View updated article show page
      redirect_to @article
    else
      # Re-render edit article page if there is an error creating
      # Errors are attached to @article and rendered with shared/_errors from _form in edit
      render 'edit'
    end
  end

  # Delete an existing article
  def destroy
    # Run destroy method on @article object
    @article.destroy
    # Successful article deletion flash message
    flash[:notice] = "Article was successfully deleted"
    # Load articles index page
    redirect_to articles_path
  end

  private

  # Set @article variable when viewing a page with user information
  # This will be the id of the article that is being viewed
  def set_article
    @article = Article.find(params[:id])
  end

  # whitelist and set article_params
  def article_params
    # Will ensure there is an article object
    # permit returns a copy of the article param object with only the listed attributes and responds true to permitted? method
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  # Ensure that users can only manipulate their own articles (or admin who can manipulate all articles)
  def require_same_user
    # Check if user does NOT match the @article author or if the user is NOT an admin
    if current_user != @article.user && !current_user.admin?
      # flash an alert if both of the above cases are true and user is NOT author or admin
      flash[:alert] = "You can only edit or delete your own article"
      # View @article show page
      redirect_to @article
    end
  end

end