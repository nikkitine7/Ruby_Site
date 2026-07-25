require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "sign in page loads" do
    get new_session_path
    assert_response :success
  end

  test "sign in succeeds for existing user" do
    user = User.create!(email: "login@example.com", password: "password123", password_confirmation: "password123")
    post session_path, params: { email: user.email, password: "password123" }
    assert_redirected_to root_path
    assert_equal user.id, session[:user_id]
  end

  test "sign out clears the session" do
    user = User.create!(email: "logout@example.com", password: "password123", password_confirmation: "password123")
    post session_path, params: { email: user.email, password: "password123" }
    delete session_path
    assert_redirected_to root_path
    assert_nil session[:user_id]
  end
end
