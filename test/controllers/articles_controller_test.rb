require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    # Create new regular user
    # @user = User.create(username: "testuser", email: "testuser@email.com", password: "testadminpass", admin: false)
    @user = create_new_user
    # @user2 = User.create(username: "testuser2", email: "testuser2@email.com", password: "testadminpass", admin: false)
    @user2 = create_new_user
    # Create new admin user
    # @admin_user = User.create(username: "adminuser", email: "adminuser@email.com", password: "testadminpass", admin: true)
    @admin_user = create_new_user(admin: true)
    # Create an article written by @user
    # This is because admin should be able to modify even though @user_admin is not assigned to it
    create_article(@user)
  end

  #### INDEX TESTS
  # Show article index page
  test "should show article index page" do
    get articles_url
    assert_response :success
  end



  #### NEW TESTS
  # Create new article method for logged in users
  test "should create new article if logged in" do
    sign_in_as(@user)
    assert_difference('Article.count', 1) do
      post articles_url, params: { article: { title: "Creating article", description: "Creating test article"} }
    end
  end

  # Block create new article method for unregistered users
  test "should not create a new article if not logged in" do
    assert_no_difference('Article.count') do
      post articles_url, params: { article: { title: "Creating article", description: "Creating test article", user: @user} }
    end
  end

  # Show new article page
  test "should show article new page if logged in" do
    # Sign in as user since non-signed in users should not access this page
    sign_in_as(@user)
    get new_article_url(@article)
    assert_response :success
  end

  # Block new article page from non-registered users
  test "should not show article new page if not logged in" do
    # Don't sign in a user so the request is redirected to login page
    get new_article_url(@article)
    assert_response :redirect
  end



  #### EDIT TESTS
  # Show the edit page for logged in users
  test "should show article edit page if logged in as @article.user" do
    # Sign in as @article.user so page is available
    sign_in_as(@user)
    get edit_article_url(@article)
    assert_response :success
  end

  #  Show the edit page for admin users even if they are not the author
  test "should show article edit page if logged in as admin" do
    # Sign in as @admin_user so edit page is available
    sign_in_as(@admin_user)
    # Ensure that the admin is not the owner of the article (defeats the purpose)
    assert @article.user != @admin_user
    get edit_article_url(@article)
    assert_response :success
  end

  # Block article edit page for non-registered users
  test "should not show article edit page if not logged in" do
    get edit_article_url(@article)
    assert_response :redirect
  end

  # Block users from editing other user articles
  test "should not show article edit page for non-author users" do
    sign_in_as(@user2)
    get edit_article_url(@article)
    assert_response :redirect
  end



  #### SHOW TESTS
  # Show a specific article
  test "should show article show page" do
    get article_url(@article)
    assert_response :success
  end
  


  #### UPDATE TESTS
  # Allow article update for logged in @article.user
  test "should update article if logged in and current user" do
    # Store initial title for comparison
    initial_title = @article.title
    sign_in_as(@user)
    patch article_url(@article), params: { article: { title: "Changed title" } }
    # Compare updated title with initial_title to ensure change was successful
    assert Article.find(@article.id).title != initial_title
  end

  # Allow article update for logged in admin
  test "should update article if logged in and admin" do
    # Store initial title for comparison
    initial_title = @article.title
    sign_in_as(@admin_user)
    # Ensure that the @article.user is not the @admin_user
    assert @article.user != @admin_user
    patch article_url(@article), params: { article: { title: "Changed title" } }
    # Compare updted title with initial title to ensure change was successful
    assert Article.find(@article.id).title != initial_title
  end

  # Block article updates for unregistered users
  test "should not update article if not logged in" do
    initial_title = @article.title
    patch article_url(@article), params: {article: { title: "Changed title" } }
    assert Article.find(@article.id).title == initial_title
  end

  # Block article updates from users who are not the article author or admin
  test "should not update article if logged in as different user (not admin)" do
    # Store initial title for comparison after attempted update
    initial_title = @article.title
    sign_in_as(@user2)
    # Ensure that signed in user is not the @article.user
    assert @article.user != @user2
    # Attempt to update article
    patch article_url(@article), params:  { article: { title: "Changed title" } }
    # Compare article in db to initial title to confirm changes were rejected
    assert Article.find(@article.id).title == initial_title
  end


  
  #### DESTROY TESTS
  # Allow users to delete their own articles
  test "should destroy article if logged in and current user" do
    sign_in_as(@user)
    assert_difference('Article.count', -1) do
      delete article_url(@article)  
    end
  end

  # Allow admins to delete other user articles
  test "should destroy article if logged in and admin" do
    sign_in_as(@admin_user)
    # Ensure that the admin account is not the owner of the article
    assert @article.user != @admin_user
    assert_difference('Article.count', -1) do
      delete article_url(@article)
    end
  end

  # Block article destruction from unregistered users
  test "should not destroy article if not logged in or current user or admin" do
    assert_no_difference('Article.count') do
      delete article_url(@article)
    end
  end

  # Block users from deleting other users articles (if not admin)
  test "should not destroy article as a different user (not admin)" do
    sign_in_as(@user2)
    assert @article.user != @user2
    assert_no_difference('Article.count') do
      delete article_url(@article)
    end
  end
end