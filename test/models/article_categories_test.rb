require 'test_helper'

class ArticleCategoriestest < ActiveSupport::TestCase
  def setup
    # For a valid ArticleCategory obj both a valid article and a valid category is needed
    # To create a valid article there needs to be a user assigned to it
    # User, article, and category obj all need to be created for @article_category
    
    # Create and save new @user object so @article can be created
    @user = create_new_user
    # Create and save new @article object for @article_category
    create_article(@user)
    # Create and save new @category object for @article_category
    @category = create_category
    # Create @article_category to test on
    @article_category = ArticleCategory.new(article_id: @article, category_id: @category)
  end

  test "should be valid" do
    assert @category.valid?
  end

  test "must have article" do
    @article_category.article_id = nil
    assert_not @article_category.valid?
  end

  test "must have category" do
    @article_category.category_id = nil
    assert_not @article_category.valid?
  end
end