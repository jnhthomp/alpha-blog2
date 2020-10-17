require 'test_helper'

# Tests for viewing categories/index
class ListCategoriesTest < ActionDispatch::IntegrationTest
  # setup for tests
  def setup
    # Create 2 new valid categories
    @category = Category.create(name: "sports")
    @category2 = Category.create(name: "travel")
  end

  # Ensure that categories/index reachable and categories are displayed
  test "should show categories listing" do
    # get categories/index
    get '/categories'
    # check for divs linking to categories created in setup
    assert_select "a[href=?]", category_path(@category), test: @category.name
    assert_select "a[href=?]", category_path(@category2), test: @category2.name
  end
end
