class Youtube::UserChannelTagRelationship < ApplicationRecord
  self.table_name = "user_channel_tag_rels"
  
  belongs_to :user
  belongs_to :youtube_channel, class_name: "Youtube::Channel"
  belongs_to :youtube_tag, class_name: "Youtube::Tag"
end
