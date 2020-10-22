require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    # Create an initial default user
    @user = create_new_user
  end

  # Test route for users index page
  test "should show users index page" do
    get users_url
    assert_response :success
  end
  
  # Test route for new user signup page
  test "should show new user signup page" do
    get signup_url
    assert_response :success
  end

  # Test that logged in users cannot access the new user signup page
  test "new user page should not be available to logged in users" do
    # Log in as a user
    post login_url, params: { session: { username: @user.username, password: @user.password } }
    # Attempt to access new user signup page
    get signup_url
    # Confirm that user is redirected to correct page
    assert_redirected_to user_url(@user)
    # Confirm that the flash alert was created
    assert_not_nil flash[:alert]
  end

  
  # Create a new user
  test "should create a new user" do
    # Check difference in user count after posting a new user to the create user route (should increase by 1)
    assert_difference('User.count', 1) do
      post users_url, params: { user: { username: "newuser", email: "newuser@email.com", password: "testpassword" } }  
    end
  end

  # Confirm that invalid user objects are not saved
  test "should not create a new user if user obj is invalid" do
    # Check difference in user count after attempting to post a new user w/ create user route (should not change)
    assert_no_difference('User.count') do
      post users_url, params: { user: { username: "", email: "", password: "" } }
    end
  end

  # Test that logged in users cannot access users#create method
  test "should not allow create a new user method if a user is already logged in" do
    # Log in as a user
    post login_url, params: { session: { username: @user.username, password: @user.password } }
    # Confirm there is no difference in user count after attempting to create a new user
    assert_no_difference('User.count') do
      post users_url, params: { user: { username: "newuser", email: "newuser@email.com", password: "testpassword" } }  
    end
    # Confirm that user is redirected to their own profile
    assert_redirected_to user_url(@user)
    # Confirm that flash alert message was created
    assert_not_nil flash[:alert]
  end

  # Test user show page route
  test "should load user show page" do
    # user show page needs a user.id to display a user
    get user_url(@user)
    assert_response :success
  end

  # Confirm that user articles are available to #show method
  test "articles written by user should be available" do
    # Create an article for the user page
    create_article(@user)
    #  Fetch the users page use #show method
    get user_url(@user)
    # Confirm page was reached
    assert_response :success
    # Confirm that @articles in #show method was created and contains the created article
    assert_not_nil assigns(:articles)
  end

  # Test user edit page route
  test "should load user edit page" do
    # Login as a user (edit page should not be reachable otherwise)
    post login_url, params: { session: { username: @user.username, password: @user.password } }
    # Edit page url needs a user.id to display a user to edit
    get edit_user_url(@user)
    assert_response :success
  end

  # Test that users cannot edit other users profiles
  test "should not load user edit page if not logged in as same user" do
    # Create a second user to login as
    @user2 = create_new_user
    # Login as second user
    post login_url, params: { session: { username: @user2.username, password: @user2.password } }
    # Confirm login was successful (personal profile loads on successful sign in)
    assert_redirected_to user_url(@user2)
    # Try to get edit page for different user
    get edit_user_url(@user)
    # Confirm that we are redirected to @user2 personal profile
    assert_redirected_to user_url(@user)
    # Confirm that flash alerts are created successfully
    assert flash[:alert]
  end

  # Test updating a user
  test "should update user" do
    # Login as a user
    post login_url, params: { session: { username: @user.username, password: @user.password} }
    # Attempt to update logged in user's profile
    patch user_url(@user), params: { user: { username: "changed_user" } }
    # Check the db to confirm that the save was successful
    assert User.find(@user.id).username == "changed_user"
  end

  # Confirm that users cannot update other user profiles via #update
  test "should not update user if not logged in as same user" do
    # Create a new second user
    @user2 = create_new_user
    # Login as second user
    post login_url, params: { session: { username: @user2.username, password: @user2.password } }
    # Attempt to update different user as second user
    patch user_url(@user), params: { user: { username: "changed_user" } }
    # Check the db to confirm that save was not successful
    assert_not User.find(@user.id).username == "changed_user"
  end

  # Test that users are able to delete their own profiles
  test "should destroy user if logged in as same user" do
    # Login as a user
    post login_url, params: { session: { username: @user.username, password: @user.password } }
    # Check for difference in User.count before and after attempting to delete the logged in user profile
    #   (should be -1)
    assert_difference('User.count', -1) do
      delete user_url(@user)  
    end
    # Confirm that user is redirected to the appropriate page
    assert_redirected_to articles_url
    # Confirm flash notice message is created
    assert flash[:notice]
    # Confirm that the user was logged out
    assert_not session[:user_id]
  end

  # Test that admins are able to delete other user profiles
  test "should destroy user if logged in as admin" do
    # Create an admin user
    @admin_user = create_new_user(username: "admin_user", admin: true)
    # Login as the admin user
    post login_url, params: { session: { username: @admin_user.username, password: @admin_user.password } }
    # Check for difference between User.count before and after attempting to delete a different users profile
    #   (should be -1)
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end
  end

  # Confirm that user articles are also deleted on user profile deletion
  test "should destroy associated user articles" do
    # Login as a user
    post login_url, params: { session: { username: @user.username, password: @user.password } }
    # Create an article for the user
    create_article(@user)
    # Check difference in Article.count before and after deleting the logged in user's profile
    #   (should be -1)
    assert_difference('Article.count', -1) do
      delete user_url(@user)
    end
  end
  
  # Test that users are not able to delete other user profile (excluding admin)
  test "should not destroy user if not logged in as same user or admin" do
    # Create a new user
    @user2 = create_new_user
    # Log in new user
    post login_url, params: { session: { username: @user2.username, password: @user2.password } }
    # Confirm that User.count does not change after attempting to delete a different user profile
    assert_no_difference('User.count') do
      delete user_url(@user)
    end
  end
end
