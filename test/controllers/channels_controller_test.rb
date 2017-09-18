require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest #ActionController::TestCase # 
    
    test "channels index page" do
        get channels_path
        assert_response :success
    end
    
    test "channels show page" do
        get channel_path(Channel.first)
        assert_response :success
    end

end