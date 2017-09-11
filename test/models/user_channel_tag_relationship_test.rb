require 'test_helper'

class UserChannelTagRelationshipTest < ActiveSupport::TestCase
  
  
  test "creating a UserChannelTagRelationship should work" do
    user = User.create(email: "myname@test.com", password: "123bonjour", password_confirmation: "123bonjour")
    tag = Tag.create(title: "ex1")
    channel = Channel.create(uid: "ex1")
    
    rel = UserChannelTagRelationship.create(user: user, tag: tag, channel: channel)
    assert rel.persisted?
    
    assert_equal user.tags, [tag]
    assert_equal user.channels, [channel]
    
    assert_equal tag.users, [user]
    assert_equal tag.channels, [channel]
    
    assert_equal channel.tags, [tag]
    assert_equal channel.users, [user]
  end
  

end
