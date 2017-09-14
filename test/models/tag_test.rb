require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test "have all its relationships ok" do
    tag = Tag.create(title: "ex1")
    assert tag.user_channel_tag_relationships
    assert tag.users
    assert tag.channels
  end
  
  test "don't create 2 tags with the same title" do
    tag_count = Tag.count
    tag1 = Tag.create(title: "ex1")
    assert_equal tag_count + 1, Tag.count
    assert tag1.persisted?
    
    #second tag with same uid is not created
    tag2 = Tag.create(title: "ex1")
    assert_equal tag_count + 1, Tag.count
    assert !tag2.persisted?
  end
  
  test "get tag with channels count hash" do
    tags_hash = Tag.all_with_channels_count
    assert_equal({"TitleOne"=>1, "TitleTwo"=>2}, tags_hash)
  end
end
