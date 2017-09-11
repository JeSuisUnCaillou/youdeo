require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest #ActionController::TestCase # 
  
  def setup
    #sign_in a new user
    post "/users", params: { 
        user:{
            email: "grotest@testmail.com",
            password: "123coucou",
            password_confirmation: "123coucou"
        }
    }
    @user = User.find_by(email: "grotest@testmail.com")
  end
  
  test "posting a tag title and a channel uid creates a tag, a channel and a relationship" do
    tag_count = Tag.count
    channel_count = Channel.count
    rel_count = UserChannelTagRelationship.count

    post tags_path, params: { tag_title: "MyTag", channel_uid: "MyUid" }
    assert_response :redirect
    
    assert_equal tag_count + 1, Tag.count
    assert_equal channel_count + 1, Channel.count
    assert_equal rel_count + 1, UserChannelTagRelationship.count
  end
  
  test "posting an existing tag title and channel uid use the existing ones in the new relationship" do
    tag = Tag.create(title: "MyTag")
    channel = Channel.create(uid: "MyUid")
    
    tag_count = Tag.count
    channel_count = Channel.count
    rel_count = UserChannelTagRelationship.count

    post tags_path, params: { tag_title: "MyTag", channel_uid: "MyUid" }
    assert_response :redirect
    
    assert_equal tag_count, Tag.count
    assert_equal channel_count, Channel.count
    assert_equal rel_count + 1, UserChannelTagRelationship.count
    
    assert_equal [tag], channel.tags
    assert_equal [channel], tag.channels
    assert_equal [tag], @user.tags
    assert_equal [channel], @user.channels
  end
  
end
