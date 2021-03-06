require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "have all its relationships ok" do
    user = User.create(email: "myname@test.com", password: "123bonjour", password_confirmation: "123bonjour")
    assert user.user_channel_tag_relationships
    assert user.tags
    assert user.channels
  end
  
  
  test "can create a user with just email and password" do
    user_count = User.count
    user = User.create(email: "myname@test.com", password: "123bonjour", password_confirmation: "123bonjour")
    
    assert_not_nil user
    assert_equal user_count + 1, User.count
  end
  
  test "can't create a user with invalid email" do
    User.create(email: "myname@", password: "123bonjour", password_confirmation: "123bonjour")
    assert_raise StandardError
  end
  
  test "can't create a user with invalid password (too short)" do
    User.create(email: "myname@test.com", password: "1", password_confirmation: "1")
    assert_raise StandardError
  end
  
  test "can't create a user with bad confirmation password" do
    User.create(email: "myname@test.com", password: "123bonjour", password_confirmation: "123bonjourTOP")
    assert_raise StandardError
  end
   
  test "can't create 2 users with same email" do
    User.create(email: "myname@test.com", password: "123bonjour", password_confirmation: "123bonjour")
    User.create(email: "myname@test.com", password: "123bonjourPareil", password_confirmation: "123bonjourPareil")
    assert_raise StandardError
  end
  
  test "can't create 2 users with same uid" do
    user = User.create(email: "myname@test.com", uid: "myUid", password: "123bonjour", password_confirmation: "123bonjour")
    user = User.create(email: "myOthername@test.com", uid: "myUid", password: "123bonjourPareil", password_confirmation: "123bonjourPareil")
    assert_raise StandardError
  end
  
  
  test "create a user from omniauth params and getting a user from omnioauth params" do
    access_token = fake_google_oauth_response
    
    user = User.from_omniauth(access_token)
    assert_not_nil user
    assert_equal "myUid", user.uid
    assert_equal "My Name", user.name
    assert_equal "my_image_url", user.google_image_url
    assert_equal "myToken", user.google_token
    assert_equal "myRefreshToken", user.google_refresh_token
    
    user2 = User.from_omniauth(access_token)
    assert_equal user, user2
  end
  
  test "if user uid exists, getting user from omniauth updates" do
    user = User.from_omniauth(fake_google_oauth_response)
    User.from_omniauth(fake_google_oauth_response(name: "new name"))
    
    assert_not_equal user.name, User.find_by(uid: user.uid).name
  end
  
  test "if user uid exists, getting user from omniauth with empty name and refresh_token doesn't update the fields" do
    acces_token = fake_google_oauth_response
    
    acces_token_with_empty = fake_google_oauth_response
    acces_token_with_empty.info.email = nil
    acces_token_with_empty.credentials.refresh_token = nil
    
    user = User.from_omniauth(acces_token)
    User.from_omniauth(acces_token_with_empty)
    
    user_in_db = User.find_by(uid: user.uid)
    
    assert_equal user.name, user_in_db.name
    assert_equal user.google_refresh_token, user_in_db.google_refresh_token
  end
  
  test "if user email doesn't exist, a fake mail is created" do
    user_count = User.count
    
    acces_token = fake_google_oauth_response
    acces_token.info.email = nil
    user = User.from_omniauth(acces_token)
    
    assert_equal user_count + 1, User.count
    assert_not_nil user.email
    assert_equal "#{user.uid.downcase}@fakemail.com", user.email
  end
  
  
  
  
  test "get tags_with_channels, and get channels_with_tags" do 
    user = User.create(email: "myname@test.com", password: "123bonjour", password_confirmation: "123bonjour")
    tag1 = Tag.create(title: "ex1")
    tag2 = Tag.create(title: "ex2")
    channel1 = Channel.create(uid: "channel1")
    channel2 = Channel.create(uid: "channel2")
    UserChannelTagRelationship.create(user: user, tag: tag1, channel: channel1)
    UserChannelTagRelationship.create(user: user, tag: tag2, channel: channel1)
    UserChannelTagRelationship.create(user: user, tag: tag2, channel: channel2)
    
    assert_equal({tag1.title => [channel1.uid], tag2.title => [channel1.uid, channel2.uid]}, user.tags_with_channels)
    assert_equal({channel1.uid => [tag1.title, tag2.title], channel2.uid => [tag2.title]}, user.channels_with_tags)
  end

  test "get all users with channel count and tag count" do
    #Using fixtures, yeah !
    result = OpenStruct.new(id: 0, name: "Alice", image_url: "", tag_count: 2, channel_count: 2)
    assert_equal([result], User.all_with_tags_and_channels_count)
  end
  
  test "split infos between tagged and untagged channels" do
    tags_hash = { title1: ["uid1"], title2: ["uid2", "uid3"] }
    channels_hash = { "uid1" => {title: "channel1"}, "uid2" => {title: "channel2"}, "uid3" => {title: "channel3"}, "uid4" => {title: "channel4"} }
    
    new_tags_hash, new_channels_hash = User.new.split_infos(tags_hash, channels_hash)
    
    assert_equal({ title1: [{title: "channel1"}], title2: [{title: "channel2"}, {title: "channel3"}] }, new_tags_hash)
    assert_equal({"uid4" => {title: "channel4"}}, new_channels_hash)
  end
  
end
