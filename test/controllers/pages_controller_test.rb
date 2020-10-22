require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest

  setup do
    # Create a new user account to use for signing in
    # @user = User.create(username: "test_user", email: "test_user@email.com", password: "testadminpass", admin: false)
    @user = create_new_user
  end

  # Make sure root route is accessible to unregistered users
  test "should get home if not logged in" do
    # Go to the root route (pages#home)
    get root_url
    # Ensure that we get the home page
    assert_response :success
  end

  # Make sure the root route is not accessible to registered users
  test "should get articles index if logged in" do
    # Sign in as the user from setup
    sign_in_as(@user)
    # Attempt to navigate to the home page
    get root_url
    # Confirm that the home page wasn't loaded and the user was redirected
    assert_response :redirect
  end
end
