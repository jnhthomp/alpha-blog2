require 'test_helper'

# Tests for creating new categories
class CreateCategoryTest < ActionDispatch::IntegrationTest

  # Setup for tests
  setup do
    # Create an admin user account
    @admin_user = User.create(username: "testadmin", email: "testadmin@email.com",
                              password: "testadminpass", admin: true)
    # Sign in the created admin 
    # Only admins should be able to create categories so we must use an admin account
    sign_in_as(@admin_user)
  end

  # Create a new category using the new category form
  test "get new category form and create category" do
    # get categories/new
    get "/categories/new"
    # ensure that we are able to get the page successfully (as an admin)
    assert_response :success
    # Check that number of categories increases after do block
    assert_difference 'Category.count', 1 do
      # Post a new category with the following name
      post categories_path, params: { category: { name: "Sports"}}
      # Check that we were redirected (we should be when useing categories#create)
      assert_response :redirect
    end
    # Follow the redirect from above (categories#create)
    follow_redirect!
    # Ensure that the page from the redirect loaded successfully
    assert_response :success
    # Check that the new category name is listed on the page that was redirected to
    assert_match "sports", response.body
  end

  # Fail to create a new invalid category
  test "get new category form and reject invalid category submission" do
    # get categories/new
    get "/categories/new"
    # ensure the page was reached successfully (as an admin)
    assert_response :success
    # Check that number of categories does not change after do block
    assert_no_difference 'Category.count' do
      # try to submit a category w/ an invalid name
      post categories_path, params: { category: { name: " "}}
    end

    # Check for the word "errors" in the page after submitting invalid entry
    assert_match "errors", response.body
    # Ensure that an alert is displayed
    assert_select 'div.alert'
    # Double check that the text for the alert is displayed
    assert_select 'h4.alert-heading'
  end
end