require 'test_helper'

class Youtube::ChannelTest < ActiveSupport::TestCase
  
  test "don't create 2 channels with the same uid" do
    channel_count = Youtube::Channel.count
    channel1 = Youtube::Channel.create(uid: "ex1")
    assert_equal channel_count + 1, Youtube::Channel.count
    
    #second channel with same uid is not created
    channel2 = Youtube::Channel.create(uid: "ex1")
    assert_equal channel_count + 1, Youtube::Channel.count
  end
end
