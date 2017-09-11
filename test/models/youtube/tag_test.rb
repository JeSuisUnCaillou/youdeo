require 'test_helper'

class Youtube::TagTest < ActiveSupport::TestCase
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
