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
  
  # test "ca, create a user with just uid and password" do
  #   user = User.create(uid: "myUid", password: "123bonjour", password_confirmation: "123bonjour")

  # end
  
  
  
  test "create a user from omniauth params" do
    access_token = OpenStruct.new(
      info: OpenStruct.new(email: "myname@test.com", name: "My Name")
    )
    user = User.from_omniauth(access_token)
    assert_not_nil user
  end
end
