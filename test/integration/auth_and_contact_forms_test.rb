require "test_helper"

class AuthAndContactFormsTest < ActionDispatch::IntegrationTest
  test "create account page shows a working form" do
    get new_user_path
    assert_response :success
    assert_includes response.body, "Create account"
  end

  test "login page shows a working form" do
    get new_session_path
    assert_response :success
    assert_includes response.body, "Sign in"
  end

  test "contact page shows a working form" do
    get new_contact_message_path
    assert_response :success
    assert_includes response.body, "Contact us"
  end

  test "sign in submission works in preview mode" do
    user = User.create!(email: "preview@example.com", password: "password123", password_confirmation: "password123")
    post session_path, params: { email: user.email, password: "password123" }
    assert_response :redirect
  end

  test "create account submission works in preview mode" do
    assert_difference("User.count", 1) do
      post users_path, params: { user: { email: "new@example.com", password: "password123", password_confirmation: "password123" } }
    end
    assert_response :redirect
  end

  test "contact message submission works in preview mode" do
    assert_difference("ContactMessage.count", 1) do
      post contact_messages_path, params: { contact_message: { name: "Tester", email: "tester@example.com", message: "Hello" } }
    end
    assert_response :redirect
  end
end
