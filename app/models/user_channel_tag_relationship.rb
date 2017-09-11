class UserChannelTagRelationship < ApplicationRecord
  self.table_name = "user_channel_tag_rels"
  
  belongs_to :user
  belongs_to :channel
  belongs_to :tag
end
