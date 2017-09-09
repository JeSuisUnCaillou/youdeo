require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "can create a user with just email and password" do
    user_count = User.count
    user = User.create(email: "myname@test.com", password: "123bonjour", password_confirmation: "123bonjour")
    
    assert_not_nil user
    assert_equal user_count + 1, User.count
  end
  
  test "can't create a user with invalid email" do
    User.create(email: "myname@", password: "123bonjour", password_confirmation: "123bonjour")
    assert_raise StandardError
  end
  
  test "can't create a user with invalid password (too short)" do
    User.create(email: "myname@test.com", password: "1", password_confirmation: "1")
    assert_raise StandardError
  end
  
  test "can't create a user with bad confirmation password" do
    User.create(email: "myname@test.com", password: "123bonjour", password_confirmation: "123bonjourTOP")
    assert_raise StandardError
  end
   
  test "can't create 2 users with same email" do
    User.create(email: "myname@test.com", password: "123bonjour", password_confirmation: "123bonjour")
    User.create(email: "myname@test.com", password: "123bonjourPareil", password_confirmation: "123bonjourPareil")
    assert_raise StandardError
  end
  
  test "can't create 2 users with same uid" do
    user = User.create(email: "myname@test.com", uid: "myUid", password: "123bonjour", password_confirmation: "123bonjour")
    user = User.create(email: "myOthername@test.com", uid: "myUid", password: "123bonjourPareil", password_confirmation: "123bonjourPareil")
    assert_raise StandardError
  end
  
  
  test "create a user from omniauth params and getting a user from omnioauth params" do
    access_token = fake_google_oauth_response
    
    user = User.from_omniauth(access_token)
    assert_not_nil user
    assert_equal "myUid", user.uid
    assert_equal "My Name", user.name
    assert_equal "my_image_url", user.google_image_url
    assert_equal "myToken", user.google_token
    assert_equal "myRefreshToken", user.google_refresh_token
    
    user2 = User.from_omniauth(access_token)
    assert_equal user, user2
  end
  
  
  
end
