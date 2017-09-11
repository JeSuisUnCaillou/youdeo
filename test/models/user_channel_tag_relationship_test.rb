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
  
  test "one user adding several tags to a channel" do
    user = User.create(email: "myname@test.com", password: "123bonjour", password_confirmation: "123bonjour")
    tag1 = Tag.create(title: "ex1")
    tag2 = Tag.create(title: "ex2")
    channel = Channel.create(uid: "channel1")
    UserChannelTagRelationship.create(user: user, tag: tag1, channel: channel)
    UserChannelTagRelationship.create(user: user, tag: tag2, channel: channel)
    
    assert_equal 2, user.tags.count
    assert_equal 1, user.channels.count
    assert_equal 1, channel.users.count
    assert_equal 2, channel.tags.count
  end
  
  test "one user adding several channels to a tag" do
    user = User.create(email: "myname@test.com", password: "123bonjour", password_confirmation: "123bonjour")
    tag = Tag.create(title: "ex1")
    channel1 = Channel.create(uid: "channel1")
    channel2 = Channel.create(uid: "channel2")
    UserChannelTagRelationship.create(user: user, tag: tag, channel: channel1)
    UserChannelTagRelationship.create(user: user, tag: tag, channel: channel2)
    
    assert_equal 1, user.tags.count
    assert_equal 2, user.channels.count
    assert_equal 2, tag.channels.count
    assert_equal 1, tag.users.count
  end
  
  test "several users adding the same tag the the same channel" do
    user1 = User.create(email: "myname1@test.com", password: "123bonjour", password_confirmation: "123bonjour")
    user2 = User.create(email: "myname2@test.com", password: "123bonjourpareil", password_confirmation: "123bonjourpareil")
    tag = Tag.create(title: "ex1")
    channel = Channel.create(uid: "channel")
    UserChannelTagRelationship.create(user: user1, tag: tag, channel: channel)
    UserChannelTagRelationship.create(user: user2, tag: tag, channel: channel)
    
    assert_equal 2, tag.users.count
    assert_equal 1, tag.channels.count
    assert_equal 1, channel.tags.count
    assert_equal 2, channel.users.count
  end
end
