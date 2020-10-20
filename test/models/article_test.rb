require 'test_helper'

class Articletest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(username: "test_user", email: "test_user@email.com", password: "test_user_pasword", admin: false)
    @user.save
    @article = Article.new(title: "Article Title", description: "Article description", user: @user)
  end
  
  # Check that @user blueprint from setup is still valid
  test "article should be valid" do
    assert @article.valid?
  end

  # Ensure user must be assigned for article to be valid
  test "must have user" do
    # remove user assigned to @article
    @article.user = nil
    assert_not @article.valid?
  end
  
  # Ensure title exists for article to be valid
  test "must have title" do
    @article.title = nil
    assert_not @article.valid?
  end
  
  # Test title length requirements (short)
  test "title should not be too short" do
    # hardcode minimum_length - 1 from article.rb
    @article.title = "a" * 5
    assert_not @article.valid?
  end

  # Test title length requirements (long)
  test "title should not be too long" do
    # hardcode maximum_length + 1 from article.rb
    @article.title = "a" * 101
    assert_not @article.valid?
  end

  # Ensure description exists for article to be valid
  test "article must have description" do
    @article.description = nil
    assert_not @article.valid?
  end
  
  # Test description length requirements (short)
  test "description cannot be too short"do
    # hardcode minimum_length - 1 from article.rb
    @article.description = "a" * 9
    assert_not @article.valid?
  end

  # Test description length requirements (long)
  test "description cannot be too long" do
    # hardcode maximum_length + 1 from article.rb
    @article.description = "a" * 301
    assert_not @article.valid?
  end
end