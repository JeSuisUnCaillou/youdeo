require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
    
    def setup
        @user = User.first
    end
    
    test "profile page should exist and contain user's name in title" do
        get user_path(id: @user.id)
        assert_response :success
        assert_select "h1", @user.name
    end
    
    test "users page should exist" do
        get users_path
        assert_response :success
    end
   
   
end
