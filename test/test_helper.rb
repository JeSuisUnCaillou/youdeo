require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  def fake_google_oauth_response
    OpenStruct.new(
      uid: "myUid",
      info: OpenStruct.new(email: "myname@test.com", name: "My Name", image: "my_image_url"),
      credentials: OpenStruct.new(token: "myToken", refresh_token: "myRefreshToken")
    )
  end
end
