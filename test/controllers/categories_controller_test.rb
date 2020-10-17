require 'test_helper'

# Tests for categories_controller.rb
class CategoriesControllerTest < ActionDispatch::IntegrationTest
  
  # Run this before each test 
  setup do
    # Create a category (otherwise none will exist)
    @category = Category.create(name: "sports")
    # Create an admin user (so they can manipulate categories)
    @admin_user = User.create(username: "testadmin", email: "testadmin@email.com",
                              password: "testadminpass", admin: true)
  end

  # Ensure categories/index route is correct
  test "should get index" do
    # get categories/index
    get categories_url 
    # Check if categories/index was reached successfully
    assert_response :success
  end

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

  # Check that category url works
  test "should show category" do
    # Get category/show
    get category_url(@category)
    # Ensure category/show was reached successfully
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_category_url(@category)
  #   assert_response :success
  # end

  # test "should update category" do
  #   patch category_url(@category), params: { category: {  } }
  #   assert_redirected_to category_url(@category)
  # end

  # test "should destroy category" do
  #   assert_difference('Category.count', -1) do
  #     delete category_url(@category)
  #   end

  #   assert_redirected_to categories_url
  # end
end
