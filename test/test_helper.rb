ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  # Sign a user in with login credentials from setup method (make sure password here matches setup password)
  # Password must be hardcoded here since it is hashed and we cannot enter the hash as a valid password
  def sign_in_as(user)
    # use the following as credentials for login user is defined in setup method for the test
    post login_path, params: { session: { username: user.username, password: "testadminpass" } }
  end

  # Create a new @user obj and save to test db (non-admin)
  def create_user
    # Set attributes for new user
    @user = User.new(username: "test_user", email: "test_user@email.com", password: "test_user_pasword", admin: false)
    # Save new user to test db
    @user.save
  end

  # Create a new @article and save to test db
  def create_article(user)
    # Set attributes for new article
    @article = Article.new(title: "Article Title", description: "Article description", user: user)
    # Save new article to test db
    @article.save
  end

  # Create a new @category and save to test db
  def create_category
    # Set attributes for new category
    @category = Category.new(name: "Category")
    # Save new category to test db
    @category.save
  end
end
