require "test_helper"

class Admin::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "admin dashboard requires admin role" do
    user = User.create!(email: "customer@example.com", password: "password123", password_confirmation: "password123")
    post session_path, params: { email: user.email, password: "password123" }
    get admin_dashboard_path
    assert_redirected_to root_path
  end
end
