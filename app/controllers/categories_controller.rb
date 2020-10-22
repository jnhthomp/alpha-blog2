class CategoriesController < ApplicationController
  # Require a user to be admin for all categories views/actions except index and show
  before_action :require_admin, except: [:index, :show]

  # Load page to view list of categories
  def index
    # Paginate all categories in categories table
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  # Create a new category from the category from categories/new
  def create
    # Update @category with values from new
    @category = Category.new(category_params)
    # format the category name to downcase for consistency
    @category.name.downcase!
    # Attempt to save the new category
    if @category.save
      # Successful category creation flash message
      flash[:notice] = "Category was successfully created"
      # Load the show page for the created category
      redirect_to @category
    else
      # Re-render new category page if there is an error creating
      # Errors are attached to @category and rendered with shared/_errors from _form in new
      render 'new'
    end
  end

  # Create a new category
  def new
    # Initialize new Category obj
    # Will be updated from the view before @category is pushed to #create
    @category = Category.new
  end

  # Edit categories page
  def edit
    # Set @category from id provided in the params when clicking a category
    @category = Category.find(params[:id])
  end

  # Load page to view individual category
  def show
    # Set @category from id provided in the params when clicking a category
    @category = Category.find(params[:id])
    # Get and paginate a list of articles associated with the selected category
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  # Update an existing category from the edit page
  def update
    # Set @category from id provided 
    @category = Category.find(params[:id])
    # Attempt to update the category with new values
    if @category.update(category_params)
      # Successfull category update flash message
      flash[:notice] = "Category name updated successfully"
      # Load @category show page
      redirect_to @category
    else
      # Re-render edit category page if there is an error creating
      # Errors are attached to @category and rendered with shared/_errors from _form in edit
      render 'edit'
    end
  end

  # Delete an existing category
  def destroy
    # Set @category form id provided
    @category = Category.find(params[:id])
    # Delete the selected category
    @category.destroy
    # Successful deletion notice
    flash[:notice] = "Category was successfully deleted"
    # Load categories/index page
    redirect_to categories_path
  end

  private

  # whitelist and set article_params
  def category_params
    # Will ensure there is an category object
    # permit returns a copy of the category param object with only the listed attribute and responds true to permitted? method
    params.require(:category).permit(:name)
  end

  # Check that user is admin before performing actions/loading views
  def require_admin
    # Check that a user is logged in and user.admin == true
    if !(logged_in? && current_user.admin?)
      # Unsuccessful flash message if user is not an admin
      flash[:alert] = "Only admins can perform that action"
      # Load categories/index page
      redirect_to categories_path
    end 
  end
  
end