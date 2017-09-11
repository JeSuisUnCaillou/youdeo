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
  
  test "check the get_account" do
    refresh_token = "1/neJAsmsyiNlDkj6sG7Df2c4afUHNkKdV5IQ9uXFmv6Q"
    account = @youtube_api.get_account(refresh_token)
    assert_equal "JeSuisUnCaill0u", account.name
  end
  
  
  
end