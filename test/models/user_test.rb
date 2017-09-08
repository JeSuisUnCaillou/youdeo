require 'test_helper'

class UserTest < ActiveSupport::TestCase
   test "create a user from omniauth params" do
     access_token = OpenStruct.new(
        info: OpenStruct.new(email: "myname@test.com", name: "My Name")
      )
     user = User.from_omniauth(access_token)
     assert_not_nil user
   end
end
