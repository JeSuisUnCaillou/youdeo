require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest #ActionController::TestCase # 
  
  test "can create a tag" do
    #sign_in a new user
    post "/users", params: { 
        user:{
            email: "grotest@testmail.com",
            password: "123coucou",
            password_confirmation: "123coucou"
        }
    }
        
    tag_count = Tag.count
    post tags_path, params: { tag: { title: "MyTag" } }
    assert_response :redirect
    assert_equal tag_count + 1, Tag.count
  end
  
end
