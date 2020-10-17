class SessionsController < ApplicationController

  # Login page
  def new
    
  end

  # Create a new user session (log in a user)
  def create
    # Search for a user that matches username provided in log in form
    user = User.find_by(username: params[:session][:username])
    # Check if a user with a matching username was found and the provided password was correct
    # .authenticate is used to check passwords since passwords are hashed with bcrypt
    #   This will check if the provided password can be used to decrypt the hash and match provided password
    if user && user.authenticate(params[:session][:password])
      # Successful login, assign user_id var to session so it is remembered across pages
      session[:user_id] = user.id
      # Successful login flash message
      flash[:notice] = "Login Was Successful"
      # Load user profile
      redirect_to user
    else
      # Unsuccessful login flash message
      flash.now[:alert] = "There was something wrong with your login details"
      # Reload the login page (flash message will be displayed on reload)
      render 'new'
    end
  end

  # Logout actoin
  def destroy
    # Set the session user_id to nil (when a user_id exists a user is logged in)
    session[:user_id] = nil
    # Successful logout flash message
    flash[:notice] = "User was logged out"
    # Reload home page (determined by root route in routes.rb)
    redirect_to root_path
  end
end