class Tag < ApplicationRecord
    validates_uniqueness_of :title
    
    has_many :user_channel_tag_relationships
    has_many :users, -> { distinct }, through: :user_channel_tag_relationships
    has_many :channels, -> { distinct }, through: :user_channel_tag_relationships
end
