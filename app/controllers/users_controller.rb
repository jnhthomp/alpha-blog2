class UsersController < ApplicationController
  # Set @user var for the user object being viewed/manipulated
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # Check that there is a user logged in before performing actions (application controller)
  before_action :require_user, only: [:edit, :update, :destroy]
  # Check that the logged in user is the same (or is an admin) as the user obj being viewed/manipulated 
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  # Signup page for new user
  # Loads users/new.html.erb
  def new
    # Create an instance variable for a new User object to register
    @user = User.new
  end

  # Create a new user to the users table from the signup form (user#new)
  def create
    # add the whitelisted user_params to @user
    @user = User.new(user_params)
    # Try to save the @user object
    if @user.save
      # if saved set the user_id of the created user as a session parameter
      # This will keep the user id available to the browser until destroyed
      session[:user_id] = @user.id
      # Add a flash notice so we know signup was successful
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up"
      # Load the articles index (flash message will show here )
      redirect_to articles_path
    else
      # if not saved reload the new user signup page
      # error messages from @user.save will be passed and shown in user/new from shared/_errors (in form)
      render 'new'
    end
  end

  # View individual user page
  def show
    # List of articles created by the user (paginated with will_paginate gem)
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  # View edit page for a user
  def edit

  end
  
  # Update user details
  def update
    # Attempt to update @user with details provided from edit page
    if @user.update(user_params)
      # Successful update flash message
      flash[:notice] = "Your account information was successfully updated"
      # Reload @user user profile
      redirect_to users_path(@user)
    else
      # Reload edit page errors are attached to @user object and rendered in edit page via _form
      render 'edit'
    end
  end

  # Delete a user object (including their articles) from the database
  def destroy
    # Select and destroy the associated user for the profile being viewed
    @user.destroy
    # If the user is deleting their own account then remove the session id
    # This will prevent oddities from them being signed into an account that doesn't exist
    session[:user_id] = nil if @user == current_user
    # flash a notice confirming successful deletion and redirect to homepage
    flash[:notice] = "Account and all associated articles have been successfully deleted"
    redirect_to root_path
  end



  private

  # Set @user variable when viewing a page with user information
  # This will be the id of the user that is being viewed regardless of who is viewing it
  def set_user
    @user = User.find(params[:id])
  end

  # whitelist and set user params
  def user_params
    # Will ensure there is a user object
    # permit returns a copy of the user param object with only the listed attributes and responds true to permitted? method
    params.require(:user).permit(:username, :email, :password)
  end

  # Check that logged in user can only manipulate their own account or they are an admin
  def require_same_user
    # Check to see if the current user is manipulating their own profile 
    # If it is not their profile check if the current user is an admin
    if current_user != @user && !current_user.admin?
      # If they are not an admin then an alert is passed and redirected to the previously viewed page
      flash[:alert] = "You can only edit or delete your own account"
      redirect_to @user
    end
    # If a user is editing their own account or they are an admin then nothing will happen here
  end

end