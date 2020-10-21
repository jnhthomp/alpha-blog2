require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "testuser", email: "testuser@email.com",
      password: "testadminpass", admin: false)
  end
    # "should load new session page (login page)"
  test "should load new session page (login page)" do
    get login_url
    assert_response :success
  end
  # "should not load new session page for logged in users"
  # "should create new session w/ valid credentials"
  test "should create new session w/ valid credentials" do
    post login_url, params: { session: { username: @user.username, password: @user.password } }
    assert_redirected_to user_url(@user)
  end
  # "shoud not create new session w/ invalid credentials"
  test "should not create new session w/ invalid credentials" do
    post login_url, params: { session: { username: @user.username, password: "wrongpassword" } }
    assert_response :success
    # See if there is a way to look for flash[:alert] messages being present instead since success is a little misleading
  end
  # "should not create new session if a user is already logged in"
  # "should destroy session if user is logged in"
  test "should destroy session if user is logged in" do
    post login_url, params: { session: { username: @user.username, password: @user.password } }
    assert_not session[:user_id] == nil
    delete logout_url(@user)
    assert session[:user_id] == nil
  end
end

