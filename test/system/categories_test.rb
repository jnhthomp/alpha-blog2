require "application_system_test_case"

# Test navigation through categories pages
class CategoriesTest < ApplicationSystemTestCase
  
  # Setup for tests
  setup do
    # idk tbh
    @category = categories(:one)
  end

  # Test that categories/index works correctly
  test "visiting the index" do
    # Go to categories/index
    visit categories_url
    # Ensure that there is an h1 element with 
    assert_selector "h1", text: "Categories"
  end

  # Test that creating a new category in browser works correctly
  test "creating a Category" do
    # Go to categories/index
    visit categories_url
    # click new category button
    click_on "New Category"

    # click create category button (already assigned value in setup?)
    click_on "Create Category"

    # Check that success flash message was displayed
    assert_text "Category was successfully created"
    click_on "Back"
  end

  # Test that updating a category in browser works as expected
  test "updating a Category" do
    # Go to categories/index
    visit categories_url
    # Click edit button on first listed category
    click_on "Edit", match: :first
    # click update category from edit page
    click_on "Update Category"
    # ensure that successful flash message is displayed
    assert_text "Category was successfully updated"
    click_on "Back"
  end

  # Test that deleting a category in browser works as expected
  test "destroying a Category" do
    # Go to categories/index
    visit categories_url
    # Run the do block and accept the pop up confirmation
    page.accept_confirm do
      # Click the destroy action for the first category listed
      click_on "Destroy", match: :first
    end

    # ensure that successful flash message is displayed
    assert_text "Category was successfully destroyed"
  end
end
