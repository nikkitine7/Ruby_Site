require "test_helper"

class ContactMessagesControllerTest < ActionDispatch::IntegrationTest
  test "contact form page loads" do
    get new_contact_message_path
    assert_response :success
  end

  test "contact form submits successfully" do
    assert_difference("ContactMessage.count", 1) do
      post contact_messages_path, params: { contact_message: { name: "Tester", email: "tester@example.com", message: "Hello" } }
    end
    assert_redirected_to root_path
  end
end
