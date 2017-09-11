class Channel < ApplicationRecord
    validates_uniqueness_of :uid
    
    has_many :user_channel_tag_relationships
    has_many :users, -> { distinct }, through: :user_channel_tag_relationships
    has_many :tags, -> { distinct }, through: :user_channel_tag_relationships
    
end
