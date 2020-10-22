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
    post login_path, params: { session: { username: user.username, password: user.password } }
  end

  # Create a new user with default values or pass in needed arguements
  def create_new_user(username: "user", email_suffix: "@email.com", password: "password", admin: nil)
    username = username + "#{User.count + 1}"
    email = username + email_suffix
    return User.create(username: username, email: email, password: password, admin: admin)
  end

  # Create a new @article and save to test db
  def create_article(user)
    # Set attributes for new article
    return Article.create(title: "Article Title", description: "Article description", user: user)
    # Save new article to test db
    # @article.save
  end

  # Create a new @category and save to test db
  def create_category
    # Set attributes for new category
    return Category.create(name: "Category")
    # Save new category to test db
    # @category.save
  end
end
