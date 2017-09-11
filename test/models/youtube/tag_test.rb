require 'test_helper'

class Youtube::TagTest < ActiveSupport::TestCase
  test "have all its relationships ok" do
    tag = Youtube::Tag.create(title: "ex1")
    assert tag.user_channel_tag_relationships
    assert tag.users
    assert tag.channels
  end
  
  test "don't create 2 tags with the same title" do
    tag_count = Youtube::Tag.count
    tag1 = Youtube::Tag.create(title: "ex1")
    assert_equal tag_count + 1, Youtube::Tag.count
    assert tag1.persisted?
    
    #second tag with same uid is not created
    tag2 = Youtube::Tag.create(title: "ex1")
    assert_equal tag_count + 1, Youtube::Tag.count
    assert !tag2.persisted?
  end
end
