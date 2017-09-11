class Tag < ApplicationRecord
    validates_uniqueness_of :title
    
    has_many :user_channel_tag_relationships
    has_many :users, through: :user_channel_tag_relationships
    has_many :channels, through: :user_channel_tag_relationships
end
