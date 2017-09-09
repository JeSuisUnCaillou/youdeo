require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
    
    def setup
        @user = User.first
    end
    
    test "profile page should exist and contain user's name in title" do
        get user_path(@user)
        assert_response :success
        assert_select "h1", @user.name
    end
   
   
end
