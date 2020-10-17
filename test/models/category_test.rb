require 'test_helper'

# Test validation for Category objects saved to db
class Categorytest < ActiveSupport::TestCase

  # Setup for tests
  def setup
    # create a new category (don't save)
    @category = Category.new(name: "sports")
  end

  # Check that the @category obj is valid
  test "category should be valid" do
    assert @category.valid?
  end

  # Check that name must be present for @category to be saved
  test "name should be present" do
    # Overwrite @category.name from setup to be empty
    @category.name = " "
    # Ensure that category is not valid
    assert_not @category.valid?
  end

  # Check that categories can not be saved with the same name
  test "name should be unique" do
    # save the @category from setup
    @category.save
    # Create another category obj with the same name
    @category2 = Category.new(name: "sports")
    # Ensure that the new category is not valid
    assert_not @category2.valid?
  end

  # Test that the category name length restriction works
  test "name should not be too long" do
    # overwrite @category.name from setup with name exceeding char limit
    @category.name = "a" * 21
    # Ensure that @category is not valid
    assert_not @category.valid?
  end

  # Test that the category name length restriction works
  test "name should not be too short" do
    # Set @category.name from setup to be too short to pass validation
    @category.name = "a" * 2
    # Ensure that @category is not valid
    assert_not @category.valid?
  end
end