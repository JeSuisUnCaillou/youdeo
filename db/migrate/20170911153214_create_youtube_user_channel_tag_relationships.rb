class CreateYoutubeUserChannelTagRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :user_channel_tag_rels do |t|
      t.references :user, foreign_key: true
      t.references :channel, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
