require 'test_helper'

class Usertest < ActiveSupport::TestCase

  def setup
    # Create and save @user obj to test db
    create_user
    # Create and save @article obj to test db with @user assigned
    create_article(@user)
  end

  # Default user that was created in setup should be valid
  test "should be valid" do
    assert @user.valid?
  end

  # "user articles should be destroyed when user is destroyed"
  test "user articles should be destroyed with user" do
    # Check that there is 1 less article in Article.count
    # Since this user has 1 article assigned 
    #  there should be 1 less article when destroying the user
    assert_difference('Article.count', -1) do # compares Article.count before and after the do block
      # remove @user from test db users table
      @user.destroy
    end
  end

  # Ensure that @user.username is present to be valid
  test "must have username" do
    # Set username to be blank
    @user.username = nil
    # Ensure that @user is now invalid
    assert_not @user.valid?
  end

  # Ensure that @user.username is unique - ignore capitalization
  #   if @user 'test' exists then @user2 'TEST' would be invalid
  test "username must be unique regardless of capitalization" do
    # Create a new user with the same username as the already saved @user
    # Change the new user username to capital to test that they are not case sensitive
    @user2 = User.new(username: @user.username.upcase!, password: "uniquepassword", email: "unique@email.com", admin: false)
    assert_not @user2.valid?
  end

  # Test length of username (short)
  test "username should not be too short" do
    # Set username to be minimum_length - 1 from user.rb
    @user.username = "a" * 2
    assert_not @user.valid?
  end

  # Test length of username (long)
  test "usename should not be too long" do
    # Set username to be maximum_length + 1 from user.rb
    @user.username = "a" * 26
    assert_not @user.valid?
  end

  # Ensure that @user.email must exist to be valid
  test "email must be present" do
    # set @user.email to be empty
    @user.email = nil
    assert_not @user.valid?
  end

  # Ensure that @user.email is unique - ignore capitalization
  #   if @user 'test@email.com' exists then @user2 'TEST@email.com' would be invalid
  test "email must be unique regardless of capitalization" do
    # Create a new user with the same email as the already saved @user
    # Change the new user email to capital to test that they are not case sensitive
    @user2 = User.new(username: "user2", password: "uniquepassword", email: @user.email.upcase!, admin: false )
    assert_not @user2.valid?
  end

  # Test length of email (long)
  #   test for length of email (short is not needed due to our regex rules test)
  test "email must not be too long" do
    # Set email to be maximum_length + 1 from user.rb
    @user.email = "a" * 100 + "@email.com"
    assert_not @user.valid?
  end

  # Check that regex is being used to filter emails
  test "email must follow regex format" do
    # Hardcoded regex from user.rb - needs updated if regex is updated
    regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    # Check that our existing user follows regex rules
    assert @user.email =~ regex
    # Give an invalid email to double check regex
    assert_not "invalid_email" =~ regex
  end

  # Make sure that email cannot be saved in uppercase
  test "email is stored in lowercase" do
    # Force @user.email to uppercase
    @user.email.upcase!
    # Save the uppercase email
    @user.save
    # Check that the saved email is not equal to the email set uppercase
    assert_not @user.email == @user.email.upcase
  end

  # Ensure that user cannot be saved without password
  test "must have password" do
    # Clear password field
    @user.password = nil
    assert_not @user.valid?
  end

  # Make sure that selected password are being hashed
  test "password is hashed" do
    # new password to use
    new_password = "newpassword"
    # save the current password digest for comparison to make sure password was updated
    previous_digest = @user.password_digest
    # update the user password and save
    @user.password = new_password
    @user.save
    # Check that the password was updated
    assert @user.password_digest != previous_digest
    # Check that the password digest does not equal the plaintext password
    assert @user.password_digest != new_password
  end

  # Ensure created users are set to not be admin by default
  test "user is not admin by default" do
    # Create a new user but don't specify if admin
    @user2 = User.new(username: "user2", password: "password", email: "user2@email.com")
    @user2.save
    # Check that admin was set to false even though it wasn't specified
    assert @user2.admin == false
  end
end

