require 'test_helper'

# Tests for categories_controller.rb
class CategoriesControllerTest < ActionDispatch::IntegrationTest
  
  # Run this before each test 
  setup do
    # Create a category (otherwise none will exist)
    @category = Category.create(name: "sports")
    # Create an admin user (so they can manipulate categories)
    # @admin_user = User.create(username: "testadmin", email: "testadmin@email.com",
                              # password: "testadminpass", admin: true)
    @admin_user = create_new_user(admin: true, password: "testadminpass")
  end

  #### INDEX TESTS
  # Ensure categories/index route is correct
  test "should get index" do
    # get categories/index
    get categories_url 
    # Check if categories/index was reached successfully
    assert_response :success
  end
  


  #### CREATE TESTS
  # Ensure that category creation functionality works
  test "should create category" do
    # Use sign in function with admin account (sign_in_as found in test_helper.rb)
    # Pass @admin_user in from setup for credentials
    sign_in_as(@admin_user)
    # Check that category.count increases after the do block
    assert_difference('Category.count', 1) do
      # Create a new catagory with the given name
      post categories_url, params: { category: { name: "travel" } }
    end

    # Check that we can view the created category show page
    assert_redirected_to category_url(Category.last)
  end

  # Ensure that normal users cannot create a new category, must be admin.
  test "should not create category if not admin" do
    # Check that category count does not change after the do block
    assert_no_difference('Category.count') do
      # Try to create a new category with the given name
      post categories_url, params: { category: { name: "travel" } }
    end
    # Check that we can view the categories index page
    assert_redirected_to categories_url
  end



  #### NEW TESTS
  # Ensure categories/new route is correct
  test "should get new" do
    # Use sign in function with admin account (sign_in_as found in test_helper.rb)
    # Pass @admin_user in from setup for credentials
    sign_in_as(@admin_user)
    # get categories/new (only accessible by admin)
    get new_category_url
    # Check if categories/new was reached successfully
    assert_response :success
  end



  #### EDIT TESTS
  # Load the edit page for a category if admin
  test "should get edit" do
    # Sign in as admin user
    sign_in_as(@admin_user)
    # Go to edit category page
    get edit_category_url(@category)
    # Confirm edit category page was returned successfully
    assert_response :success
  end



  #### SHOW TESTS
  # Check that category url works
  test "should show category" do
    # Get category/show
    get category_url(@category)
    # Ensure category/show was reached successfully
    assert_response :success
  end



  #### UPDATE TESTS
  # Ensure that admin users are able to update category
  test "should update category" do
    # Sign in as admin user
    sign_in_as(@admin_user)
    # Pass new category name to the update path for an existing category
    patch category_url(@category), params: { category: { name: "travel" } }
    # Ensure that we were redirected to the category page (successfully)
    assert_redirected_to category_url(@category)
  end

  # Ensure that non admin users cannot update a category
  test "should not update category if not admin" do
    # Note the initial name of the category (should not change)
    initial_name = @category.name
    # Attempt to update the category name
    patch category_url(@category), params: { category: { name: "travel"} }
    # Compare with the initial name to ensure it hasn't changed
    assert @category.name == initial_name
  end


  
  #### DESTROY TESTS
  # Ensure that admin users are able to destroy existing categories
  test "should destroy category" do
    # Sign in as admin user
    sign_in_as(@admin_user)
    # Compare the initial number of existing categories to before and after do block
    #   (should be -1)
    assert_difference('Category.count', -1) do
      # Delete the category from categories table
      delete category_url(@category)
    end
    # Ensure that we were redirected to categories index (successful)
    assert_redirected_to categories_url
  end

  # Ensure that non admin users are not able to destroy existing categories
  test "should not destroy category if not admin" do
    # Compare initial number of existing categoires to before and after do block
    #   (should be the same)
    assert_no_difference('Category.count') do
      # Attempt to delete the category from the user table
      delete category_url(@category)
    end
  end
end
