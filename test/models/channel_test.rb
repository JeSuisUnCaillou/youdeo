require 'test_helper'

class ChannelTest < ActiveSupport::TestCase
  
  test "have all its relationships ok" do
    channel = Channel.create(uid: "ex1")
    assert channel.user_channel_tag_relationships
    assert channel.users
    assert channel.tags
  end
  
  test "don't create 2 channels with the same uid" do
    channel_count = Channel.count
    channel1 = Channel.create(uid: "ex1")
    assert_equal channel_count + 1, Channel.count
    assert channel1.persisted?
    
    #second channel with same uid is not created
    channel2 = Channel.create(uid: "ex1")
    assert_equal channel_count + 1, Channel.count
    assert !channel2.persisted?
  end
end
