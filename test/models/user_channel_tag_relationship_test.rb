require 'test_helper'

class UserChannelTagRelationshipTest < ActiveSupport::TestCase
  
  
  test "creating a UserChannelTagRelationship should work" do
    user = User.create(email: "myname@test.com", password: "123bonjour", password_confirmation: "123bonjour")
    tag = Tag.create(title: "ex1")
    channel = Channel.create(uid: "ex1")
    
    rel = UserChannelTagRelationship.create(user: user, tag: tag, channel: channel)
    assert rel.persisted?
    
    assert_equal [tag], user.tags
    assert_equal [channel], user.channels
    
    assert_equal [user], tag.users
    assert_equal [channel], tag.channels
    
    assert_equal [tag], channel.tags
    assert_equal [user], channel.users
  end
  

end
