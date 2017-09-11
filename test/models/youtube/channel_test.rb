require 'test_helper'

class Youtube::ChannelTest < ActiveSupport::TestCase
  
  test "have all its relationships ok" do
    channel = Youtube::Channel.create(uid: "ex1")
    assert channel.user_channel_tag_relationships
    assert channel.users
    assert channel.tags
  end
  
  test "don't create 2 channels with the same uid" do
    channel_count = Youtube::Channel.count
    channel1 = Youtube::Channel.create(uid: "ex1")
    assert_equal channel_count + 1, Youtube::Channel.count
    assert channel1.persisted?
    
    #second channel with same uid is not created
    channel2 = Youtube::Channel.create(uid: "ex1")
    assert_equal channel_count + 1, Youtube::Channel.count
    assert !channel2.persisted?
  end
end
