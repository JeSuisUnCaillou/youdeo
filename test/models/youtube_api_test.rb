require 'test_helper'

class YoutubeApiTest < ActiveSupport::TestCase
  
  setup do
    @youtube_api = YoutubeApi.new()
    
    Yt.configure do |config|
      config.log_level = :debug
    end
  end
  
  test "basic check of the youtube API" do
    video = @youtube_api.get_video 'dQw4w9WgXcQ'
    assert_equal video.title, 'Rick Astley - Never Gonna Give You Up'
  end
  
  test "get_account with a refresh_token" do
    refresh_token = "1/neJAsmsyiNlDkj6sG7Df2c4afUHNkKdV5IQ9uXFmv6Q"
    account = @youtube_api.get_account(refresh_token)
    assert_equal "JeSuisUnCaill0u", account.name
  end
  
  test "get_account with a user" do
    user = User.first
    user.google_refresh_token = "1/neJAsmsyiNlDkj6sG7Df2c4afUHNkKdV5IQ9uXFmv6Q"
    account = @youtube_api.get_account(user)
    assert_equal "JeSuisUnCaill0u", account.name
  end
  
  test "get account's channels" do
    user = User.first 
    user.google_refresh_token = "1/neJAsmsyiNlDkj6sG7Df2c4afUHNkKdV5IQ9uXFmv6Q"
    channels = @youtube_api.get_subscribed_channels(user)

    assert 100 < channels.count, "channels count must be over 100 for JeSuisUnCaill0u"
    first_channel = channels.values.first
    assert_not_nil first_channel.uid
    assert_not_nil first_channel.thumbnail_url
    assert_not_nil first_channel.title
    assert_not_nil first_channel.video_count
  end
  
  
end