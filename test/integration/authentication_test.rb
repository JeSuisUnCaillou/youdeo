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
    assert_redirected_to root_path
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