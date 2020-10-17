class ApplicationController < ActionController::Base
  # Helper methods must be declared to be available to our views
  helper_method :current_user, :logged_in?

  # Set @current_user instance variable
  def current_user
    # ||= will set @current_user if @current_user doesn't exist yet
    # If session params has a user_id stored see if that user id is in users table
    # The matching user from the users table will be set as @current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Checks if the current user is logged in or not with current_user method
  def logged_in?
    # !! will return the result of current_user method as a boolean
    # If @current_user exists then logged_in? returns true 
    #  if it is empty or unassigned then logged_in? returns false
    !!current_user # Consider updating to object.present? instead as it will return empty objects as false ex: [], {}, ""
  end

  # Require a user to be logged in to perform actions
  def require_user
    # Will check if a user is logged in
    if !logged_in?
      # If false then a flash alert is passed and the user is redirected
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end
end
