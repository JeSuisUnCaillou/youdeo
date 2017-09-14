class Tag < ApplicationRecord
    validates_uniqueness_of :title
    
    has_many :user_channel_tag_relationships
    has_many :users, -> { distinct }, through: :user_channel_tag_relationships
    has_many :channels, -> { distinct }, through: :user_channel_tag_relationships
    
    def self.all_with_channels_count
            Tag.joins(:user_channel_tag_relationships)
            .group("tags.title")
            .pluck('tags.title, COUNT(user_channel_tag_rels.channel_id) as channels_count')
            .to_h
    end
    
    def self.all_with_channels
        Tag.joins(:channels)
            .pluck("tags.title, channels.uid")
            .inject({}) { |hash, columns|
                if hash[columns[0]]
                    hash[columns[0]] << columns[1]
                else
                    hash[columns[0]] = [columns[1]]
                end
                hash
            }
    end
end
