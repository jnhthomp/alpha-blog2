require 'test_helper'

# Tests for modifying categories
class ModifyCategoryTest < ActionDispatch::IntegrationTest
    # Setup for tests
    setup do
      # Create an admin user account
      @admin_user = create_new_user(username: "admin_user", admin: true)
      # Sign in the created admin 
      # Only admins should be able to create categories so we must use an admin account
      sign_in_as(@admin_user)
      # post categories_url, params: { category: { name: "travel" } }
      
    end

    test "Create a new category and save it, attach an article, then modify category name " do
      @category = create_category
      # Create article
      @article = create_article(@admin_user)
      # Confirm that article was created successfully
      assert Article.last == @article
      # Attach the created category to the new article
      @article.categories << @category
      assert @article.categories.count == 1
      @article.save
      # Update the category name
      @category.name = "new_name"
      @category.save
      assert Article.last.categories.last.name == "new_name"
    end
end