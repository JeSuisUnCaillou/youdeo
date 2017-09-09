require 'test_helper'
 
class AuthenticationTest < ActionDispatch::IntegrationTest
  
  test "can see the sign up page" do
    get "/users/sign_up"
    assert_select "h2", "Sign up"
  end
  
  test "can sign up" do
    user_count = User.count
    post "/users", params: { 
        user:{
            email: "grotest@testmail.com",
            password: "123coucou",
            password_confirmation: "123coucou"
        }
    }
    assert_response :redirect
    assert_redirected_to user_path(User.last)
    assert_equal user_count + 1, User.count
  end
  
  test "sign up with google makes a redirection to their login service and creates a user" do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:google_oauth2, fake_google_oauth_response)
    
    user_count = User.count
    
    get user_google_oauth2_omniauth_authorize_path
    assert_response :redirect
    assert_match(/\/users\/auth\/google_oauth2\/callback/, @response.redirect_url)

    @request.env['omniauth.auth'] = fake_google_oauth_response
    get user_google_oauth2_omniauth_callback_path
    assert_response :redirect
    assert_redirected_to user_path(User.last)
    assert_equal user_count + 1, User.count
  end
  
  
  test "can see the sign in page" do
    get "/users/sign_in"
    assert_select "h2", "Log in"
  end
  
  test "can sign in" do
    post "/users/sign_in", params: { 
        user:{
            email: "grotest@testmail.com",
            password: "123coucou",
        }
    }
    assert_response :success
  end
  
  
end