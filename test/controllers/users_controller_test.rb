require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "new account page loads" do
    get new_user_path
    assert_response :success
  end

  test "creating a user works" do
    assert_difference("User.count", 1) do
      post users_path, params: { user: { email: "newuser@example.com", password: "password123", password_confirmation: "password123" } }
    end
    assert_redirected_to root_path
  end
end
