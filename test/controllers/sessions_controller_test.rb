require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create_new_user
    @user2 = create_new_user
  end

  #### NEW TESTS
  # "should load new session page (login page)"
  test "should load new session page (login page)" do
    # Attempt to access the login page
    get login_url
    # Confirm that the login page was reached successfully
    assert_response :success
  end

  # Prevent logged in users from accessing login page
  test "should not load new session page for logged in users" do
    # Log in a user
    sign_in_as(@user)
    # Attempt to load login page as logged in user
    get login_url
    # Confirm that user was redirected to their own profile
    assert_redirected_to user_url(@user)
    # Confirm that flash messages were set
    assert flash[:alert]
  end
  


  #### CREATE TESTS
  # Use valid login details for successful sign in
  test "should create new session w/ valid credentials" do
    # Set session params to use to post to sessions#create method
    # uses user object from setup
    sign_in_as(@user)
    # Confirm that the signed in user page was opened as specified in controller
    assert_redirected_to user_url(@user)
  end

  # Use invalid login details for unsuccessful sign in
  test "should not create new session w/ invalid credentials" do
    # Set session params to use to post to sessions#create method
    # Leaving this as is instead of @sign_in_as(@user) since an incorrect password needs to be provided
    # Sign in user will only sign in a user with the correct password information at this time
    post login_url, params: { session: { username: @user.username, password: "wrongpassword" } }
    # Confirm that the login page was reloaded (login was unsuccessful)
    assert_response :success
    # Confirm that there are flash alerts to display
    assert flash[:alert]
  end

  # "should not create new session if a user is already logged in"
  test "should not create new session if a user is already logged in" do
    # Set session params to use to post to sessions#create method to sign user in
    sign_in_as(@user)
    # Confirm that user was logged in successfully
    assert_redirected_to user_url(@user)
    # Attempt to use post route to sign in again
    sign_in_as(@user2)
    # Confirm that the page was redirected correctly 
    #   tested with articles_path/url to confirm that it was following the correct path 
    #   since the same page is loaded on successful login and when this check is hit in sessions#create
    assert_redirected_to user_url(@user)
    # Confirm that the flash alert was passed successfully
    assert flash[:alert]
  end



  #### DESTROY TESTS
  # Destroy a user session to logout a signed in user
  test "should destroy session if user is logged in" do
    # Successfully sign a user in
    sign_in_as(@user)
    # Confirm that sign in was successful - session[:user_id] will have a int value when a user is signed in
    assert_not_nil session[:user_id]
    # Run sessions#destroy to clear session[:user_id]
    delete logout_url(@user)
    # Confirm that session[:user_id] was successfully cleared
    assert session[:user_id] == nil
  end
end

