require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  def fake_google_oauth_response(**params)
    uid = params[:uid] || "myUid"
    email = params[:email] || "myname@test.com"
    name = params[:name] || "My Name"
    image = params[:image] || "my_image_url"
    token = params[:token] || "myToken"
    refresh_token = params[:refresh_token] || "myRefreshToken"
    
    OpenStruct.new(
      uid: uid,
      info: OpenStruct.new(email: email, name: name, image: image),
      credentials: OpenStruct.new(token: token, refresh_token: refresh_token)
    )
  end
  
  
end
